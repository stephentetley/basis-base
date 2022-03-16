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
/// Locale is a wrapper over the Java class `java.util.Locale`.
///
/// A Locale is typically used to supply regional / language information
/// to formatting functions that print dates, times, numbers, etc or to help
/// localize user interfaces.
///
/// This module generally follows `java.util.Locale` so the Javadoc documentation 
/// is relevant.
///
pub opaque type Locale = ##java.util.Locale

instance ToString[Locale] {
    pub def toString(x: Locale): String = Locale.toString(x)
}

/*
instance FromString[Locale] {
    pub def fromString(x: String): Option[Locale] =
        import new java.util.Locale(String): ##java.util.Locale & Pure as newLocale;
        try {
            Some(Locale(newLocale(x)))
        } catch {
            case _: ##java.lang.Exception => None
        }
}
*/

instance Eq[Locale] {
    pub def eq(x: Locale, y: Locale): Bool = Locale.equals(x, y)
}

instance Hash[Locale] {
    pub def hash(x: Locale): Int32 = Locale.hashCode(x)
}

/// No Order, so no Boxable


namespace Locale {


    /// `new` functions should not return Result as there isn't a tangible notion of failure.
    /// Unrecognized locales can be built - operations on them just don't produce results.


    ///
    /// Returns a new Locale for the supplied language.
    ///
    pub def newLocale(language: String): Locale =
        import new java.util.Locale(String): ##java.util.Locale & Pure as new1;
        Locale(new1(language))

    ///
    /// Returns a new Locale for the supplied language and country.
    ///
    pub def newLocaleWithCountry(r: {language :: String, country :: String}): Locale =
        import new java.util.Locale(String, String): ##java.util.Locale & Pure as new1;
        Locale(new1(r.language, r.country))

    ///
    /// Returns a new Locale for the supplied language, country and variant.
    ///
    /// `variant` is an arbitrary tag to distinguish this Locale from other locales 
    /// representing the same country and language.
    ///
    /// For guidelines to the formatting of a valid tag see the Javadoc for `java.util.Locale`.
    /// 
    pub def newLocaleWithVariant(r: {language :: String, country :: String, variant :: String}): Locale =
        import new java.util.Locale(String, String, String): ##java.util.Locale & Pure as new1;
        Locale(new1(r.language, r.country, r.variant))


    pub def getDefault(): Locale & Impure =
        import static java.util.Locale.getDefault(): ##java.util.Locale & Impure;
        Locale(getDefault())

    pub def setJvmDefaultLocale!(x: Locale): Result[Unit, String] & Impure =
        import static java.util.Locale.setDefault(##java.util.Locale): Unit & Impure;
        try {
            let Locale(x1) = x;
            setDefault(x1);
            Ok()
        } catch {
            case _: ##java.lang.Exception => Err("setJvmDefaultLocale! failed")
        }

    /// 
    /// `Category` is an enum for Locale categories.
    /// 
    /// Case `Display` represents the default locale for displaying user interfaces.
    //
    /// Case `Format` represents the default locale for formatting dates / times / numbers etc.
    //
    pub enum Category with Eq, Order, ToString {
        case Display
        case Format
    }


    pub def getDefaultWithCategory(x: Category): Locale & Impure =
        import static java.util.Locale.getDefault(##java.util.Locale$Category): ##java.util.Locale & Impure;
        import static get java.util.Locale$Category.DISPLAY: ##java.util.Locale$Category & Pure as getDisplay;
        import static get java.util.Locale$Category.FORMAT: ##java.util.Locale$Category & Pure as getFormat;
        match x {
            case Display => getDisplay() |> getDefault |> Locale
            case Format  => getFormat() |> getDefault |> Locale
        }

    pub def setJvmDefaultLocaleWithCategory!(category: Category, x: Locale): Result[Unit, String] & Impure =
        import static java.util.Locale.setDefault(##java.util.Locale$Category, ##java.util.Locale): Unit & Impure;
        import static get java.util.Locale$Category.DISPLAY: ##java.util.Locale$Category & Pure as getDisplay;
        import static get java.util.Locale$Category.FORMAT: ##java.util.Locale$Category & Pure as getFormat;
        try {
            let Locale(x1) = x;
            let category = match category {
                case Display => getDisplay()
                case Format => getFormat()
            };
            setDefault(category, x1);
            Ok()
        } catch {
            case _: ##java.lang.Exception => Err("setDefaultWithCategory! failed")
        }

    pub def equals(x: Locale, y: Locale): Bool =
        import java.util.Locale.equals(##java.lang.Object): Bool & Pure;
        let Locale(x1) = x;
        let Locale(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def toString(x: Locale): String =
        import java.util.Locale.toString(): String & Pure;
        let Locale(x1) = x;
        toString(x1)

    pub def hashCode(x: Locale): Int32 =
        import java.util.Locale.hashCode(): Int32 & Pure;
        let Locale(x1) = x;
        hashCode(x1)

    ///
    /// Returns the "root" locale.
    /// 
    /// The root locale has empty string for country, language and variant.
    ///
    pub def root(): Locale =
        import static get java.util.Locale.ROOT: ##java.util.Locale & Pure as getROOT;
        Locale(getROOT())

    ///
    /// Returns the locale for country Canada with language English.
    /// 
    pub def canada(): Locale =
        import static get java.util.Locale.CANADA: ##java.util.Locale & Pure as getCANADA;
        Locale(getCANADA())

    ///
    /// Returns the locale for country Canada with language French.
    /// 
    pub def canada_french(): Locale =
        import static get java.util.Locale.CANADA_FRENCH: ##java.util.Locale & Pure as getCANADA_FRENCH;
        Locale(getCANADA_FRENCH())

    pub def china(): Locale =
        import static get java.util.Locale.CHINA: ##java.util.Locale & Pure as getCHINA;
        Locale(getCHINA())

    pub def chinese(): Locale =
        import static get java.util.Locale.CHINESE: ##java.util.Locale & Pure as getCHINESE;
        Locale(getCHINESE())

    pub def english(): Locale =
        import static get java.util.Locale.ENGLISH: ##java.util.Locale & Pure as getENGLISH;
        Locale(getENGLISH())

    pub def france(): Locale =
        import static get java.util.Locale.FRANCE: ##java.util.Locale & Pure as getFRANCE;
        Locale(getFRANCE())

    pub def french(): Locale =
        import static get java.util.Locale.FRENCH: ##java.util.Locale & Pure as getFRENCH;
        Locale(getFRENCH())

    pub def german(): Locale =
        import static get java.util.Locale.GERMAN: ##java.util.Locale & Pure as getGERMAN;
        Locale(getGERMAN())

    pub def germany(): Locale =
        import static get java.util.Locale.GERMANY: ##java.util.Locale & Pure as getGERMANY;
        Locale(getGERMANY())

    pub def italian(): Locale =
        import static get java.util.Locale.ITALIAN: ##java.util.Locale & Pure as getITALIAN;
        Locale(getITALIAN())

    pub def italy(): Locale =
        import static get java.util.Locale.ITALY: ##java.util.Locale & Pure as getITALY;
        Locale(getITALY())

    pub def japan(): Locale =
        import static get java.util.Locale.JAPAN: ##java.util.Locale & Pure as getJAPAN;
        Locale(getJAPAN())

    pub def japanese(): Locale =
        import static get java.util.Locale.JAPANESE: ##java.util.Locale & Pure as getJAPANESE;
        Locale(getJAPANESE())

    pub def korea(): Locale =
        import static get java.util.Locale.KOREA: ##java.util.Locale & Pure as getKOREA;
        Locale(getKOREA())

    pub def korean(): Locale =
        import static get java.util.Locale.KOREAN: ##java.util.Locale & Pure as getKOREAN;
        Locale(getKOREAN())

    pub def prc(): Locale =
        import static get java.util.Locale.PRC: ##java.util.Locale & Pure as getPRC;
        Locale(getPRC())


    pub def simplified_chinese(): Locale =
        import static get java.util.Locale.SIMPLIFIED_CHINESE: ##java.util.Locale & Pure as getSIMPLIFIED_CHINESE;
        Locale(getSIMPLIFIED_CHINESE())

    pub def taiwan(): Locale =
        import static get java.util.Locale.TAIWAN: ##java.util.Locale & Pure as getTAIWAN;
        Locale(getTAIWAN())

    pub def traditional_chinese(): Locale =
        import static get java.util.Locale.TRADITIONAL_CHINESE: ##java.util.Locale & Pure as getTRADITIONAL_CHINESE;
        Locale(getTRADITIONAL_CHINESE())

    pub def uk(): Locale =
        import static get java.util.Locale.UK: ##java.util.Locale & Pure as getUK;
        Locale(getUK())

    pub def us(): Locale =
        import static get java.util.Locale.US: ##java.util.Locale & Pure as getUS;
        Locale(getUS())


    pub def getCountry(x: Locale): String =
        import java.util.Locale.getCountry(): String & Pure;
        let Locale(x1) = x;
        getCountry(x1)

    pub def getLanguage(x: Locale): String =
        import java.util.Locale.getLanguage(): String & Pure;
        let Locale(x1) = x;
        getLanguage(x1)

    pub def getScript(x: Locale): String =
        import java.util.Locale.getScript(): String & Pure;
        let Locale(x1) = x;
        getScript(x1)

    pub def getISO3Country(x: Locale): Option[String] =
        import java.util.Locale.getISO3Country(): String & Pure;
        try {
            let Locale(x1) = x;
            Some(getISO3Country(x1))
        } catch {
            case _: ##java.util.MissingResourceException => None
        }

    pub def getISO3Language(x: Locale): Option[String] =
        import java.util.Locale.getISO3Language(): String & Pure;
        try {
            let Locale(x1) = x;
            Some(getISO3Language(x1))
        } catch {
            case _: ##java.util.MissingResourceException => None
        }

    pub def getDisplayLanguage(x: Locale): String =
        import java.util.Locale.getDisplayLanguage(): String & Pure;
        let Locale(x1) = x;
        getDisplayLanguage(x1)

    pub def getDisplayLanguageInLocale(x: Locale, inLocale: Locale): String =
        import java.util.Locale.getDisplayLanguage(##java.util.Locale): String & Pure;
        let Locale(x1) = x;
        let Locale(inLocale1) = inLocale;
        getDisplayLanguage(x1, inLocale1)


    pub def hasExtensions(x: Locale): Bool =
        import java.util.Locale.hasExtensions(): Bool & Pure;
        let Locale(x1) = x;
        hasExtensions(x1)

    pub def stripExtensions(x: Locale): Locale =
        import java.util.Locale.stripExtensions(): ##java.util.Locale & Pure;
        let Locale(x1) = x;
        Locale(stripExtensions(x1))


    pub def toLanguageTag(x: Locale): String =
        import java.util.Locale.toLanguageTag(): String & Pure;
        let Locale(x1) = x;
        toLanguageTag(x1)

    pub def forLanguageTag(tag: String): Locale =
        import static java.util.Locale.forLanguageTag(String): ##java.util.Locale & Pure;
        Locale(forLanguageTag(tag))



    /// This marshals okay...
    pub def getAvailableLocales(): Array[Locale] & Impure =
        import static java.util.Locale.getAvailableLocales(): Array[##java.util.Locale] & Impure;
        let arr = getAvailableLocales();
        Array.map(Locale, arr)

    pub enum IsoCountryCode with Eq, Order, Boxable, Hash, ToString {
        case Part1Alpha2
        case Part1Alpha3
        case Part3
    }

    pub def isoCountryCodeToNative(x: IsoCountryCode): ##java.util.Locale$IsoCountryCode =
        import static get java.util.Locale$IsoCountryCode.PART1_ALPHA2: ##java.util.Locale$IsoCountryCode & Pure as getPart1Alpha2;
        import static get java.util.Locale$IsoCountryCode.PART1_ALPHA3: ##java.util.Locale$IsoCountryCode & Pure as getPart1Alpha3;
        import static get java.util.Locale$IsoCountryCode.PART3: ##java.util.Locale$IsoCountryCode & Pure as getPart3;
        match x {
            case Part1Alpha2    => getPart1Alpha2()
            case Part1Alpha3    => getPart1Alpha3()
            case Part3          => getPart3()
        }


    pub def getIsoCountries(): Result[Array[String], String] & Impure =
        import static java.util.Locale.getISOCountries(): Array[String] & Impure;
        try {
            let arr = getISOCountries();
            Ok(arr)
        } catch {
            case _: ##java.lang.Exception => Err("getIsoCountries")
        }

    pub def getIsoCountriesWithIsoCountryCode(icc: IsoCountryCode): Result[Set[String], String] & Impure =
        import static java.util.Locale.getISOCountries(##java.util.Locale$IsoCountryCode): ##java.util.Set & Impure;
        try {
            let icc1 = isoCountryCodeToNative(icc);
            let s1 = getISOCountries(icc1);
            Ok(Marshal.unmarshalSet(x -> x as String,s1))
        } catch {
            case _: ##java.lang.Exception => Err("getIsoCountriesWithIsoCountryCode")
        }

    pub def getIsoLanguages(): Result[List[String], String] & Impure =
        import static java.util.Locale.getISOLanguages(): Array[String] & Impure;
        try {
            let arr = getISOLanguages();
            Ok(Array.toList(arr))
        } catch {
            case _: ##java.lang.Exception => Err("getIsoLanguages")
        }


    pub def getUnicodeLocaleAttributes(x: Locale): Result[Set[String], String] & Impure =
        import java.util.Locale.getUnicodeLocaleAttributes(): ##java.util.Set & Impure;
        try {
            let Locale(x1) = x;
            let s1 = getUnicodeLocaleAttributes(x1);
            Ok(Marshal.unmarshalSet(x -> x as String,s1))
        } catch {
            case _: ##java.lang.Exception => Err("getUnicodeLocaleAttributes")
        }


    pub def getUnicodeLocaleKeys(x: Locale): Result[Set[String], String] & Impure =
        import java.util.Locale.getUnicodeLocaleKeys(): ##java.util.Set & Impure;
        try {
            let Locale(x1) = x;
            let s1 = getUnicodeLocaleKeys(x1);
            Ok(Marshal.unmarshalSet(x -> x as String,s1))
        } catch {
            case _: ##java.lang.Exception => Err("getUnicodeLocaleKeys")
        }

}
