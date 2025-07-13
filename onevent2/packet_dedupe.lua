require('common')
local ffi = require('ffi')
local struct = require('struct')

local packet_dedupe = {
    last_chunk_buffer = nil,
    reference_buffer = {},  -- Array of recent chunk buffers (each is a table of packet strings)
    max_buffer_size = 3,    -- Keep last 3 chunks only
}

function packet_dedupe.record_packets(e)

    if e.chunk_size == 0 then
        packet_dedupe.last_chunk_buffer = {}
        return
    end
    -- If last_chunk_buffer exists and current chunk equals previous chunk, 
    -- insert last chunk buffer
    -- Use memcmp to quickly detect if current chunk raw data matches last processed chunk;
    -- only then do we treat packets from last chunk as candidates for duplicates.
    if packet_dedupe.last_chunk_buffer and ffi.C.memcmp(e.data_raw, e.chunk_data_raw, e.size) == 0 then
        if #packet_dedupe.reference_buffer >= packet_dedupe.max_buffer_size then
            table.remove(packet_dedupe.reference_buffer, #packet_dedupe.reference_buffer)
        end
        table.insert(packet_dedupe.reference_buffer, 1, packet_dedupe.last_chunk_buffer)
    end

    -- Always prepare new last_chunk_buffer for current chunk
    packet_dedupe.last_chunk_buffer = {}

    local offset = 0
    while offset < e.chunk_size do
        local size = ashita_bits.unpack_be(e.chunk_data_raw, offset, 9, 7) * 4
        if size == 0 then break end -- safety check

        local chunk_packet = struct.unpack('c' .. size, e.chunk_data, offset + 1)
        table.insert(packet_dedupe.last_chunk_buffer, chunk_packet)
        offset = offset + size
    end
end

function packet_dedupe.is_duplicate_packet(e)
    -- Unpack packet data to string once
    local packet = struct.unpack('c' .. e.size, e.data, 1)
    -- Check all recent buffered packets for duplicate
    for _, chunk in ipairs(packet_dedupe.reference_buffer) do
        for _, buffered_packet in ipairs(chunk) do
            if packet == buffered_packet then
                return true
            end
        end
    end
    return false
end

return packet_dedupe