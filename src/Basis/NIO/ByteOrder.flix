/*
 * Copyright 2022 Stephen Tetley
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


namespace Basis/NIO/ByteOrder {

    use Basis/NIO/ByteOrder.ByteOrder
    use Basis/NIO/ByteOrder.ByteOrder.{BigEndian, LittleEndian}

    pub enum ByteOrder with Eq, Order, ToString, Hash, Boxable {
        case BigEndian
        case LittleEndian
    }


    pub def marshallByteOrder(x: ByteOrder): Interop/NIO.ByteOrder =
        match x {
            case BigEndian    => Interop/NIO/ByteOrder.big_endian()
            case LittleEndian => Interop/NIO/ByteOrder.little_endian()
        }


    pub def unmarshallByteOrder(x: Interop/NIO.ByteOrder): ByteOrder =
        match x {
            case n if primEquals(n, Interop/NIO/ByteOrder.big_endian())     => BigEndian
            case n if primEquals(n, Interop/NIO/ByteOrder.little_endian())  => LittleEndian
            case _                                                          => bug!("unmarshallByteOrder")
        }

    def primEquals(x: Interop/NIO.ByteOrder, y: Interop/NIO.ByteOrder): Bool = 
        Interop/NIO/ByteOrder.toString(x) == Interop/NIO/ByteOrder.toString(y)

    pub def nativeOrder(): ByteOrder \ IO = 
        Interop/NIO/ByteOrder.nativeOrder() |> unmarshallByteOrder

}
