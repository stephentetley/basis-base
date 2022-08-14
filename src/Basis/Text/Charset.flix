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

namespace Basis/Text {

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
    pub enum Charset(Interop/NIO/Charset.Charset)

    instance ToString[Charset] {
        pub def toString(cs: Charset): String =
            let Charset(cs1) = cs;
            Interop/NIO/Charset/Charset.toString(cs1)
    }

    instance Eq[Charset] {
        pub def eq(x: Charset, y: Charset): Bool = 
            let Charset(x1) = x;
            let Charset(y1) = y;
            Interop/NIO/Charset/Charset.equals(x1, y1)
    }

    instance Hash[Charset] {
        pub def hash(cs: Charset): Int32 =
            let Charset(cs1) = cs;
            Interop/NIO/Charset/Charset.hashCode(cs1)
    }

    instance Order[Charset] {
        pub def compare(x: Charset, y: Charset): Comparison =
            let Charset(x1) = x;
            let Charset(y1) = y;
            Interop/NIO/Charset/Charset.compareTo(x1, y1) |> Comparison.fromInt32
    }

    instance Boxable[Charset]

    instance Interop/Flix.Marshal[Charset] {
        pub def toJavaObject(cs: Charset): ##java.lang.Object = 
            let Charset(cs1) = cs;
            Interop/Flix/Marshal.toJavaObject(cs1)
        
        pub def fromJavaObject(o: ##java.lang.Object): Charset = 
            Charset(Interop/Flix/Marshal.fromJavaObject(o))
    }

}

namespace Basis/Text/Charset {

    use Basis/Text.Charset;
    use Basis/Text.Charset.{Charset};

    use Basis/I18n.Locale;
    use Basis/I18n.Locale.{Locale};

    
    pub def getCharset(cs: Charset): Interop/NIO/Charset.Charset = 
        let Charset(cs1) = cs;
        cs1

    pub def forName(name: String): Option[Charset] =
        Interop/NIO/Charset/Charset.forName(name) |> Result.map(Charset) |> Result.toOption

    pub def forNameWithDefault(d: Charset, name: String): Charset =
        forName(name) |> Option.getWithDefault(d)


    pub def defaultCharset(): Charset \ IO =
        Interop/NIO/Charset/Charset.defaultCharset() |> Charset


    pub def isSupported(name: String): Bool \ IO =
        Interop/NIO/Charset/Charset.isSupported(name) |> Result.getWithDefault(false)

    pub def iso_8859_1(): Charset =
        Interop/NIO/Charset/StandardCharsets.iso_8859_1() |> Charset

    pub def us_ascii(): Charset =
        Interop/NIO/Charset/StandardCharsets.us_ascii() |> Charset

    pub def utf_16(): Charset =
        Interop/NIO/Charset/StandardCharsets.utf_16() |> Charset

    pub def utf_16be(): Charset =
        Interop/NIO/Charset/StandardCharsets.utf_16be() |> Charset

    pub def utf_16le(): Charset =
        Interop/NIO/Charset/StandardCharsets.utf_16le() |> Charset

    pub def utf_8(): Charset =
        Interop/NIO/Charset/StandardCharsets.utf_8() |> Charset


    /// 
    /// Returns the canonical name of Charset `c`.
    /// 
    pub def name(cs: Charset): String =
        getCharset(cs) |> Interop/NIO/Charset/Charset.name

    /// 
    /// Returns the human readable name of the Charset `c`.
    /// 
    /// The name is interpreted using the system's default locale.
    ///
    pub def displayName(cs: Charset): String \ IO =
        getCharset(cs) |> Interop/NIO/Charset/Charset.displayName

    /// 
    /// Returns the human readable name of the Charset `c`.
    /// 
    /// The name is interpreted using the supplied locale.
    ///    
    pub def displayNameWithLocale(loc: Locale, cs: Charset): String =
        let loc1 = Basis/I18n/Locale.getLocale(loc);
        getCharset(cs) |> Interop/NIO/Charset/Charset.displayNameWithLocale(loc1)

    pub def isRegistered(cs: Charset): Bool =
        getCharset(cs) |> Interop/NIO/Charset/Charset.isRegistered

    pub def canEncode(cs: Charset): Bool =
        getCharset(cs) |> Interop/NIO/Charset/Charset.canEncode


    // pub def contains(x: Charset, y: Charset): Bool =
    //     import java.nio.charset.Charset.contains(##java.nio.charset.Charset): Bool & Pure;
    //     let Charset(x1) = x;
    //     let Charset(y1) = y;
    //     contains(x1, y1)

    pub def aliases(cs: Charset): Set[String] =
        getCharset(cs) |> Interop/NIO/Charset/Charset.aliases

    pub def availableCharsets(): Map[String, Charset] \ IO =
        Interop/NIO/Charset/Charset.availableCharsets() |> Map.map(Charset)



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
