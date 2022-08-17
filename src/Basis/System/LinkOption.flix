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


namespace Basis/System/LinkOption {


    pub enum LinkOption with Eq, Order, ToString, Hash, Boxable {
        case NofollowLinks
    }


    pub def marshallLinkOption(x: LinkOption): Interop/NIO/File.LinkOption =
        match x {
            case NofollowLinks => Interop/NIO/File/LinkOption.nofollow_links()
        }


    pub def unmarshallLinkOption(x: Interop/NIO/File.LinkOption): LinkOption =
        match x {
            case n if primEquals(n, Interop/NIO/File/LinkOption.nofollow_links())               => NofollowLinks
            case _                                                                              => bug!("unmarshallLinkOption")
        }

    def primEquals(x: Interop/NIO/File.LinkOption, y: Interop/NIO/File.LinkOption): Bool = 
        Interop/Lang/Enum.equals(Interop/Lang/SubEnum.toEnum(x), Interop/Lang/SubEnum.toEnum(y))

}
