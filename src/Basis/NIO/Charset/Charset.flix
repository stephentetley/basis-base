/*
 * Copyright 2020 Stephen Tetley
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

namespace Basis/NIO/Charset {

    /// 
    /// Charset is a wrapper over the Java class `java.nio.charset.Charset`.
    ///
    /// A Charset represents the assignment of numeric values to characters 
    /// (a coded character set) and a mapping of elements this coded character 
    /// set to octets.
    ///
    /// A Charset is typically used in encode or decode String data when this 
    /// data interfaces with the world outside Flix - e.g. reading from and 
    /// and writing to text files, network sockets, operating system processs etc.
    ///
    /// This module generally follows the class `java.nio.charset.Charset` 
    /// so the Javadoc documentation is relevant.
    ///
    pub type alias Charset = Interop/NIO/Charset.Charset

}

namespace Basis/NIO/Charset/Charset {

    use Basis/NIO/Charset.Charset;

    use Basis/Util.Locale;
    use Basis/Util.Locale.{Locale};


    pub def forName(name: String): Option[Charset] =
        Interop/NIO/Charset/Charset.forName(name) |> Result.toOption

    pub def forNameWithDefault(d: Charset, name: String): Charset =
        forName(name) |> Option.getWithDefault(d)


    pub def defaultCharset(): Charset \ IO =
        Interop/NIO/Charset/Charset.defaultCharset()


    pub def isSupported(name: String): Bool \ IO =
        Interop/NIO/Charset/Charset.isSupported(name) |> Result.getWithDefault(false)

    pub def iso_8859_1(): Charset =
        Interop/NIO/Charset/StandardCharsets.iso_8859_1()

    pub def us_ascii(): Charset =
        Interop/NIO/Charset/StandardCharsets.us_ascii()

    pub def utf_16(): Charset =
        Interop/NIO/Charset/StandardCharsets.utf_16()

    pub def utf_16be(): Charset =
        Interop/NIO/Charset/StandardCharsets.utf_16be()

    pub def utf_16le(): Charset =
        Interop/NIO/Charset/StandardCharsets.utf_16le()

    pub def utf_8(): Charset =
        Interop/NIO/Charset/StandardCharsets.utf_8()


    /// 
    /// Returns the canonical name of Charset `c`.
    /// 
    pub def name(cs: Charset): String =
        Interop/NIO/Charset/Charset.name(cs)

    /// 
    /// Returns the human readable name of the Charset `c`.
    /// 
    /// The name is interpreted using the system's default locale.
    ///
    pub def displayName(cs: Charset): String \ IO =
        Interop/NIO/Charset/Charset.displayName(cs)

    /// 
    /// Returns the human readable name of the Charset `c`.
    /// 
    /// The name is interpreted using the supplied locale.
    ///    
    pub def displayNameWithLocale(loc: Locale, cs: Charset): String =
        Interop/NIO/Charset/Charset.displayNameWithLocale(loc, cs)

    pub def isRegistered(cs: Charset): Bool =
        Interop/NIO/Charset/Charset.isRegistered(cs)

    pub def canEncode(cs: Charset): Bool =
        Interop/NIO/Charset/Charset.canEncode(cs)


    // pub def contains(x: Charset, y: Charset): Bool =
    //     import java.nio.charset.Charset.contains(##java.nio.charset.Charset): Bool & Pure;
    //     let Charset(x1) = x;
    //     let Charset(y1) = y;
    //     contains(x1, y1)

    pub def aliases(cs: Charset): Set[String] =
        Interop/NIO/Charset/Charset.aliases(cs)

    pub def availableCharsets(): Map[String, Charset] \ IO =
        Interop/NIO/Charset/Charset.availableCharsets()



    // pub def encode(cs: Charset, s: String): ##java.nio.ByteBuffer = 
    //     import java.nio.charset.Charset.encode(String): ##java.nio.ByteBuffer & Pure;
    //     let Charset(cs1) = cs;
    //     encode(cs1, s)

    // pub def encodeCharBuffer(cs: Charset, cb: ##java.nio.CharBuffer): ##java.nio.ByteBuffer = 
    //     import java.nio.charset.Charset.encode(##java.nio.CharBuffer): ##java.nio.ByteBuffer & Pure;
    //     let Charset(cs1) = cs;
    //     encode(cs1, cb)
    
    // pub def decode(cs: Charset, cb: ##java.nio.ByteBuffer): ##java.nio.CharBuffer = 
    //     import java.nio.charset.Charset.decode(##java.nio.ByteBuffer): ##java.nio.CharBuffer & Pure;
    //     let Charset(cs1) = cs;
    //     decode(cs1, cb)
    

}
