// SPDX-License-Identifier: CAL
pragma solidity =0.8.18;

library LibExtrospection {
    function scanBytesPresent(Pointer cursor, uint256 length) internal pure returns (uint256 bytesPresent) {
        assembly ("memory-safe") {
            cursor := sub(cursor, 0x20)
            let end := add(cursor, length)
            for {} lt(cursor, end) {} {
                cursor := add(cursor, 1)

                let op := and(mload(cursor), 0xFF)
                bytesPresent := or(bytesPresent, shl(op, 1))

                let push := sub(op, 0x60)
                if lt(push, 0x20) { cursor := add(cursor, push) }
            }
        }
    }
}