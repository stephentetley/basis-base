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
pub enum Charset(##java.nio.charset.Charset)

instance ToString[Charset] {
    pub def toString(cs: Charset): String =
        import java.nio.charset.Charset.toString(): String & Pure;
        let Charset(cs1) = cs;
        toString(cs1)
}


instance Eq[Charset] {
    pub def eq(x: Charset, y: Charset): Bool = Charset.equals(x, y)
}

instance Hash[Charset] {
    pub def hash(x: Charset): Int32 = Charset.hashCode(x)
}

instance Order[Charset] {
    pub def compare(x: Charset, y: Charset): Comparison =
        Charset.compareTo(x, y) |> Comparison.fromInt32
}

instance Boxable[Charset]



namespace Charset {


    pub def forName(name: String): Option[Charset] =
        import static java.nio.charset.Charset.forName(String): ##java.nio.charset.Charset & Pure;
        try {
            Some(Charset(forName(name)))
        } catch {
            case _: ##java.lang.Exception => None
        }

    pub def forNameWithDefault(d: Charset, name: String): Charset =
        forName(name) |> Option.getWithDefault(d)


    pub def defaultCharset(): Charset & Impure =
        import static java.nio.charset.Charset.defaultCharset(): ##java.nio.charset.Charset & Impure;
        Charset(defaultCharset())


    pub def isSupported(name: String): Bool =
        import static java.nio.charset.Charset.isSupported(String): Bool & Pure;
        try {
            isSupported(name)
        } catch {
            case _: ##java.lang.Exception => false
        }

    pub def iso_8859_1(): Charset =
        import static get java.nio.charset.StandardCharsets.ISO_8859_1: ##java.nio.charset.Charset & Pure as get_ISO_8859_1;
        Charset(get_ISO_8859_1())

    pub def us_ascii(): Charset =
        import static get java.nio.charset.StandardCharsets.US_ASCII: ##java.nio.charset.Charset & Pure as get_US_ASCII;
        Charset(get_US_ASCII())

    pub def utf_16(): Charset =
        import static get java.nio.charset.StandardCharsets.UTF_16: ##java.nio.charset.Charset & Pure as get_UTF_16;
        Charset(get_UTF_16())

    pub def utf_16be(): Charset =
        import static get java.nio.charset.StandardCharsets.UTF_16BE: ##java.nio.charset.Charset & Pure as get_UTF_16BE;
        Charset(get_UTF_16BE())

    pub def utf_16le(): Charset =
        import static get java.nio.charset.StandardCharsets.UTF_16LE: ##java.nio.charset.Charset & Pure as get_UTF_16LE;
        Charset(get_UTF_16LE())

    pub def utf_8(): Charset =
        import static get java.nio.charset.StandardCharsets.UTF_8: ##java.nio.charset.Charset & Pure as get_UTF_8;
        Charset(get_UTF_8())

    pub def equals(x: Charset, y: Charset): Bool =
        import java.nio.charset.Charset.equals(##java.lang.Object): Bool & Pure;
        let Charset(x1) = x;
        let Charset(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(cs: Charset): Int32 =
        import java.nio.charset.Charset.hashCode(): Int32 & Pure;
        let Charset(cs1) = cs;
        hashCode(cs1)

    pub def compareTo(x: Charset, y: Charset): Int32 =
        import java.nio.charset.Charset.compareTo(##java.nio.charset.Charset): Int32 & Pure;
        let Charset(x1) = x;
        let Charset(y1) = y;
        compareTo(x1, y1)


    /// 
    /// Returns the canonical name of Charset `c`.
    /// 
    pub def name(c: Charset): String =
        import java.nio.charset.Charset.name(): String & Pure;
        let Charset(c1) = c;
        name(c1)

    /// 
    /// Returns the human readable name of the Charset `c`.
    /// 
    /// The name is interpreted using the system's default locale.
    ///
    pub def displayName(c: Charset): String =
        import java.nio.charset.Charset.displayName(): String & Pure;
        let Charset(c1) = c;
        displayName(c1)

    /// 
    /// Returns the human readable name of the Charset `c`.
    /// 
    /// The name is interpreted using the supplied locale.
    ///    
    pub def displayNameWithLocale(c: Charset, locale: Locale): String =
        import java.nio.charset.Charset.displayName(##java.util.Locale): String & Pure;
        let Charset(c1) = c;
        let Locale(locale1) = locale;
        displayName(c1, locale1)

    pub def isRegistered(cs: Charset): Bool =
        import java.nio.charset.Charset.isRegistered(): Bool & Pure;
        let Charset(cs1) = cs;
        isRegistered(cs1)

    pub def canEncode(cs: Charset): Bool =
        import java.nio.charset.Charset.canEncode(): Bool & Pure;
        let Charset(cs1) = cs;
        canEncode(cs1)


    pub def contains(x: Charset, y: Charset): Bool =
        import java.nio.charset.Charset.contains(##java.nio.charset.Charset): Bool & Pure;
        let Charset(x1) = x;
        let Charset(y1) = y;
        contains(x1, y1)

    pub def aliases(x: Charset): Set[String] =
        import java.nio.charset.Charset.aliases(): ##java.util.Set & Pure;
        let Charset(x1) = x;
        (aliases(x1) |> Marshal.unmarshalSet(key -> key as String)) as & Pure


    pub def availableCharsets(): Map[String, Charset] =
        import static java.nio.charset.Charset.availableCharsets(): ##java.util.SortedMap & Pure;
        let downcastV = x1 -> Charset(x1 as ##java.nio.charset.Charset);
        (availableCharsets() |> Marshal.unmarshalSortedMap(k -> k as String, downcastV)) as & Pure



    pub def encode(cs: Charset, s: String): ##java.nio.ByteBuffer = 
        import java.nio.charset.Charset.encode(String): ##java.nio.ByteBuffer & Pure;
        let Charset(cs1) = cs;
        encode(cs1, s)

    pub def encodeCharBuffer(cs: Charset, cb: ##java.nio.CharBuffer): ##java.nio.ByteBuffer = 
        import java.nio.charset.Charset.encode(##java.nio.CharBuffer): ##java.nio.ByteBuffer & Pure;
        let Charset(cs1) = cs;
        encode(cs1, cb)
    
    pub def decode(cs: Charset, cb: ##java.nio.ByteBuffer): ##java.nio.CharBuffer = 
        import java.nio.charset.Charset.decode(##java.nio.ByteBuffer): ##java.nio.CharBuffer & Pure;
        let Charset(cs1) = cs;
        decode(cs1, cb)
    

}
