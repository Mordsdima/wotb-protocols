meta:
  id: bwpacket_login_in
  endian: le
enums:
  element_ids:
    0xff: reply
types:
  reply:
    seq:
      - id: reply_length
        type: u4
      - id: element_req_id
        type: u4
        if: _root.flags & 1 == 1 or _root.element_id == element_ids::reply
      - id: reply_data
        size: reply_length - 4
  element:
    doc: Not present from server when logging-in, so unnecessary in this case, present just because because, also a bit incorrect
    seq:
      - id: element_length
        type: u2
      - id: element_data
        size: element_length
seq:
 - id: flags
   type: u2
 - id: element_id
   type: u1
   enum: element_ids
 - id: reply
   type: reply
 