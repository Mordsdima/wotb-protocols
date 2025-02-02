meta:
  id: bwpacket_login_out
  endian: le
enums:
  element_ids:
    0x00: login
    0x02: ping
types:
  element_ping:
    seq:
      - id: ping_num
        type: u1
  
  element_login:
    seq:
      - id: protocol_version
        type: u4
      - id: login_data
        size: _root.element.element_length - 4

  element:
    seq:
      - id: element_length
        type: 
          switch-on: _root.element_id
          cases:
            element_ids::login: u2
      - id: element_req_id
        type: u4
        if: _root.flags & 1 == 1
      - id: element_next_offset
        type: u2 
        if: _root.flags & 1 == 1
      - id: element_data
        type:
          switch-on: _root.element_id
          cases:
            element_ids::ping: element_ping
            element_ids::login: element_login
seq:

  - id: flags
    type: u2
  - id: element_id
    type: u1
    enum: element_ids
  - id: element
    type: element
  - id: footer
    doc: likely?
    type: u2