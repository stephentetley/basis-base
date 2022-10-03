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


namespace Basis/NIO/File/StandardOpenOption {


    pub enum StandardOpenOption with Eq, Order, ToString, Hash, Boxable {
        case Append
        case Create
        case CreateNew
        case DeleteOnClose
        case Dsync
        case ReadAccess
        case Sparse
        case Sync
        case TruncateExisting
        case WriteAccess
    }


    pub def marshallStandardOpenOption(x: StandardOpenOption): Interop/NIO/File.StandardOpenOption =
        match x {
            case Append             => Interop/NIO/File/StandardOpenOption.append()
            case Create             => Interop/NIO/File/StandardOpenOption.create()
            case CreateNew          => Interop/NIO/File/StandardOpenOption.create_new()
            case DeleteOnClose      => Interop/NIO/File/StandardOpenOption.delete_on_close()
            case Dsync              => Interop/NIO/File/StandardOpenOption.dsync()
            case ReadAccess         => Interop/NIO/File/StandardOpenOption.read()
            case Sparse             => Interop/NIO/File/StandardOpenOption.sparse()
            case Sync               => Interop/NIO/File/StandardOpenOption.sync()
            case TruncateExisting   => Interop/NIO/File/StandardOpenOption.truncate_existing()
            case WriteAccess        => Interop/NIO/File/StandardOpenOption.write()
        }


    pub def unmarshallStandardOpenOption(x: Interop/NIO/File.StandardOpenOption): StandardOpenOption =
        match x {
            case n if primEquals(n, Interop/NIO/File/StandardOpenOption.append())               => Append
            case n if primEquals(n, Interop/NIO/File/StandardOpenOption.create())               => Create
            case n if primEquals(n, Interop/NIO/File/StandardOpenOption.create_new())           => CreateNew
            case n if primEquals(n, Interop/NIO/File/StandardOpenOption.delete_on_close())      => DeleteOnClose
            case n if primEquals(n, Interop/NIO/File/StandardOpenOption.dsync())                => Dsync
            case n if primEquals(n, Interop/NIO/File/StandardOpenOption.read())                 => ReadAccess
            case n if primEquals(n, Interop/NIO/File/StandardOpenOption.sparse())               => Sparse
            case n if primEquals(n, Interop/NIO/File/StandardOpenOption.sync())                 => Sync
            case n if primEquals(n, Interop/NIO/File/StandardOpenOption.truncate_existing())    => TruncateExisting
            case n if primEquals(n, Interop/NIO/File/StandardOpenOption.write())                => WriteAccess
            case _                                                                              => bug!("unmarshallStandardOpenOption")
        }

    def primEquals(x: Interop/NIO/File.StandardOpenOption, y: Interop/NIO/File.StandardOpenOption): Bool = 
        Interop/Lang/Enum.equals(Interop/Lang/SubEnum.toEnum(x), Interop/Lang/SubEnum.toEnum(y))

}
