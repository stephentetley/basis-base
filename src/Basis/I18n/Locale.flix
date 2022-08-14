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

namespace Basis/I18n {

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
    pub enum Locale(Interop/Util.Locale)

    instance ToString[Locale] {
        pub def toString(x: Locale): String = 
            let Locale(x1) = x;
            Interop/Util/Locale.toString(x1)
    }

    instance Eq[Locale] {
        pub def eq(x: Locale, y: Locale): Bool =
            let Locale(x1) = x;
            let Locale(y1) = y;
            Interop/Util/Locale.equals(x1, y1)
    }

    instance Hash[Locale] {
        pub def hash(x: Locale): Int32 = 
            let Locale(x1) = x;
            Interop/Util/Locale.hashCode(x1)
    }

    /// No Order, so no Boxable

    instance Interop/Flix.Marshal[Locale] {
        pub def toJavaObject(loc: Locale): ##java.lang.Object = 
            let Locale(loc1) = loc;
            Interop/Flix/Marshal.toJavaObject(loc1)
        
        pub def fromJavaObject(o: ##java.lang.Object): Locale = 
            Locale(Interop/Flix/Marshal.fromJavaObject(o))
    }

}



namespace Basis/I18n/Locale {

    use Basis/I18n.Locale;
    use Basis/I18n.Locale.{Locale};

    use Basis/I18n/Locale.LanguageRange;
    use Basis/I18n/Locale.LanguageRange.{LanguageRange};

    
    pub def getLocale(loc: Locale): Interop/Util.Locale = 
        let Locale(loc1) = loc;
        loc1


    /// 
    /// `Category` is an enum for Locale categories.
    /// 
    /// Case `Display` represents the default locale for displaying user interfaces.
    //
    /// Case `Format` represents the default locale for formatting dates / times / numbers etc.
    //
    pub type alias Category = Interop/Util/Locale.Category


    pub type alias FilteringMode = Interop/Util/Locale.FilteringMode

    pub type alias IsoCountryCode = Interop/Util/Locale.IsoCountryCode


    /// Design note
    /// `new` functions should not return Result as there isn't a tangible notion of failure.
    /// Unrecognized locales can be built - operations on them won't produce results.


    ///
    /// Returns a new Locale for the supplied language.
    ///
    pub def newLocale(lang: String): Locale =
        Interop/Util/Locale.newLocale(lang) |> Locale

    ///
    /// Returns a new Locale for the supplied language and country.
    ///
    pub def newLocaleWithCountry(lang: {lang :: String}, country: {country :: String}): Locale =
        Interop/Util/Locale.newLocaleWithCountry(lang = lang.lang, country = country.country) |> Locale

    ///
    /// Returns a new Locale for the supplied language, country and variant.
    ///
    /// `variant` is an arbitrary tag to distinguish this Locale from other locales 
    /// representing the same country and language.
    ///
    /// For guidelines to the formatting of a valid tag see the Javadoc for `java.util.Locale`.
    /// 
    pub def newLocaleWithVariant(lang: {lang :: String}, country: {country :: String}, variant: {variant :: String}): Locale =
        Interop/Util/Locale.newLocaleWithVariant(lang = lang.lang, country = country.country, variant = variant.variant) |> Locale



    pub def setJvmDefaultLocale!(loc: Locale): Result[Unit, String] \ IO =
        getLocale(loc) |> Interop/Util/Locale.setJvmDefaultLocale!




    pub def setJvmDefaultLocaleWithCategory!(category: Category, loc: Locale): Result[Unit, String] \ IO =
        getLocale(loc) |> Interop/Util/Locale.setJvmDefaultLocaleWithCategory!(category)

    ///
    /// Returns the "root" locale.
    /// 
    /// The root locale has empty string for country, language and variant.
    ///
    pub def root(): Locale =
        Interop/Util/Locale.root() |> Locale

    ///
    /// Returns the locale for country Canada with language English.
    /// 
    pub def canada(): Locale =
        Interop/Util/Locale.canada() |> Locale

    ///
    /// Returns the locale for country Canada with language French.
    /// 
    pub def canada_french(): Locale =
        Interop/Util/Locale.canada_french() |> Locale

    pub def china(): Locale =
        Interop/Util/Locale.china() |> Locale

    pub def chinese(): Locale =
        Interop/Util/Locale.chinese() |> Locale

    pub def english(): Locale =
        Interop/Util/Locale.english() |> Locale

    pub def france(): Locale =
        Interop/Util/Locale.france() |> Locale

    pub def french(): Locale =
        Interop/Util/Locale.french() |> Locale

    pub def german(): Locale =
        Interop/Util/Locale.german() |> Locale

    pub def germany(): Locale =
        Interop/Util/Locale.germany() |> Locale

    pub def italian(): Locale =
        Interop/Util/Locale.italian() |> Locale

    pub def italy(): Locale =
        Interop/Util/Locale.italy() |> Locale

    pub def japan(): Locale =
        Interop/Util/Locale.japan() |> Locale

    pub def japanese(): Locale =
        Interop/Util/Locale.japanese() |> Locale

    pub def korea(): Locale =
        Interop/Util/Locale.korea() |> Locale

    pub def korean(): Locale =
        Interop/Util/Locale.korean() |> Locale

    pub def prc(): Locale =
        Interop/Util/Locale.prc() |> Locale

    pub def simplified_chinese(): Locale =
        Interop/Util/Locale.simplified_chinese() |> Locale

    pub def taiwan(): Locale =
        Interop/Util/Locale.taiwan() |> Locale

    pub def traditional_chinese(): Locale =
        Interop/Util/Locale.traditional_chinese() |> Locale

    pub def uk(): Locale =
        Interop/Util/Locale.uk() |> Locale

    pub def us(): Locale =
        Interop/Util/Locale.us() |> Locale


    pub def getDefault(): Locale \ IO =
        Interop/Util/Locale.getDefault() |> Locale

    pub def getDefaultWithCategory(cat: Category): Locale \ IO =
        Interop/Util/Locale.getDefaultWithCategory(cat) |> Locale

    pub def getCountry(loc: Locale): String =
        getLocale(loc) |> Interop/Util/Locale.getCountry

    pub def getLanguage(loc: Locale): String =
        getLocale(loc) |> Interop/Util/Locale.getLanguage

    pub def getScript(loc: Locale): String =
        getLocale(loc) |> Interop/Util/Locale.getScript

    pub def getISO3Country(loc: Locale): Option[String] =
        getLocale(loc) |> Interop/Util/Locale.getISO3Country |> Result.toOption

    pub def getISO3Language(loc: Locale): Option[String] =
        getLocale(loc) |> Interop/Util/Locale.getISO3Language |> Result.toOption

    pub def getDisplayCountry(loc: Locale): String =
        getLocale(loc) |> Interop/Util/Locale.getDisplayCountry

    pub def getDisplayCountryWithLocale(inLocale: {inLocale :: Locale}, loc: Locale): String =
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(loc1) = loc;
        Interop/Util/Locale.getDisplayCountryWithLocale(inLocale = inLocale1, loc1)

    pub def getDisplayLanguage(loc: Locale): String =
        getLocale(loc) |> Interop/Util/Locale.getDisplayLanguage


    pub def getDisplayLanguageWithLocale(inLocale: {inLocale :: Locale}, loc: Locale): String =
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(loc1) = loc;
        Interop/Util/Locale.getDisplayLanguageWithLocale(inLocale = inLocale1, loc1)

    pub def getDisplayName(loc: Locale): String =
        getLocale(loc) |> Interop/Util/Locale.getDisplayName

    pub def getDisplayNameWithLocale(inLocale: {inLocale :: Locale}, loc: Locale): String =
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(loc1) = loc;
        Interop/Util/Locale.getDisplayNameWithLocale(inLocale = inLocale1, loc1)

    pub def getDisplayScript(loc: Locale): String =
        getLocale(loc) |> Interop/Util/Locale.getDisplayScript

    pub def getDisplayScriptWithLocale(inLocale: {inLocale :: Locale}, loc: Locale): String =
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(loc1) = loc;
        Interop/Util/Locale.getDisplayScriptWithLocale(inLocale = inLocale1, loc1)


    pub def getDisplayVariant(loc: Locale): String =
        getLocale(loc) |> Interop/Util/Locale.getDisplayVariant

    pub def getDisplayVariantWithLocale(inLocale: {inLocale :: Locale}, loc: Locale): String =
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(loc1) = loc;
        Interop/Util/Locale.getDisplayVariantWithLocale(inLocale = inLocale1, loc1)

    pub def hasExtensions(loc: Locale): Bool =
        getLocale(loc) |> Interop/Util/Locale.hasExtensions

    pub def stripExtensions(loc: Locale): Locale =
        getLocale(loc) |> Interop/Util/Locale.stripExtensions |> Locale


    pub def toLanguageTag(loc: Locale): String =
        getLocale(loc) |> Interop/Util/Locale.toLanguageTag

    pub def forLanguageTag(tag: String): Locale =
        Interop/Util/Locale.forLanguageTag(tag) |> Locale



    pub def getAvailableLocales(): List[Locale] \ IO =
        Interop/Util/Locale.getAvailableLocales() |> List.map(Locale)

    pub def getIsoCountries(): List[String] =
        Interop/Util/Locale.getIsoCountries()

    pub def getIsoCountriesWithIsoCountryCode(icc: IsoCountryCode): Result[Set[String], String] =
        Interop/Util/Locale.getIsoCountriesWithIsoCountryCode(icc)

    pub def getIsoLanguages(): Result[List[String], String] =
        Interop/Util/Locale.getIsoLanguages()

    pub def getExtension(key: Char, loc: Locale): Option[String] =
        getLocale(loc) |> Interop/Util/Locale.getExtension(key) |> Result.toOption

    pub def getExtensionKeys(loc: Locale): Set[Char] =
        getLocale(loc) |> Interop/Util/Locale.getExtensionKeys


    pub def getUnicodeLocaleAttributes(loc: Locale): Set[String] =
        getLocale(loc) |> Interop/Util/Locale.getUnicodeLocaleAttributes

    pub def getUnicodeLocaleKeys(loc: Locale): Set[String] =
        getLocale(loc) |> Interop/Util/Locale.getUnicodeLocaleKeys

    pub def lookup(priorityList: List[LanguageRange], locales: List[Locale]): Option[Locale] = 
        let ps = List.map(Basis/I18n/Locale/LanguageRange.getLanguageRange, priorityList);
        let ls = List.map(getLocale, locales);
        Interop/Util/Locale.lookup(ps, ls) 
            |> Result.map(Option.map(Locale))
            |> Result.getWithDefault(None) 


    pub def lookupTag(priorityList: List[LanguageRange], tags: List[String]): Option[String] = 
        let ps = List.map(Basis/I18n/Locale/LanguageRange.getLanguageRange, priorityList);
        Interop/Util/Locale.lookupTag(ps, tags)
            |> Result.getWithDefault(None)

    pub def filter(priorityList: List[LanguageRange], locales: List[Locale]): List[Locale] = 
        let ps = List.map(Basis/I18n/Locale/LanguageRange.getLanguageRange, priorityList);
        let ls = List.map(getLocale, locales);
        Interop/Util/Locale.filter(ps, ls) 
            |> Result.map(List.map(Locale))
            |> Result.getWithDefault(Nil)

    pub def filterWithFilteringMode(priorityList: List[LanguageRange], mode: FilteringMode, locales: List[Locale]): List[Locale] = 
        let ps = List.map(Basis/I18n/Locale/LanguageRange.getLanguageRange, priorityList);
        let ls = List.map(getLocale, locales);
        Interop/Util/Locale.filterWithFilteringMode(ps, mode, ls) 
            |> Result.map(List.map(Locale))
            |> Result.getWithDefault(Nil)

    pub def filterTags(priorityList: List[LanguageRange], tags: List[String]): List[String] = 
        let ps = List.map(Basis/I18n/Locale/LanguageRange.getLanguageRange, priorityList);
        Interop/Util/Locale.filterTags(ps, tags) |> Result.getWithDefault(Nil)

    pub def filterTagsWithFilteringMode(priorityList: List[LanguageRange], mode: FilteringMode, tags: List[String]): List[String] = 
        let ps = List.map(Basis/I18n/Locale/LanguageRange.getLanguageRange, priorityList);
        Interop/Util/Locale.filterTagsWithFilteringMode(ps, mode, tags) |> Result.getWithDefault(Nil)


}
