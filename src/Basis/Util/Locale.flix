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

namespace Basis/Util {

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
    pub type alias Locale = Interop/Util.Locale


    /// No Order, so no Boxable


}



namespace Basis/Util/Locale {

    use Basis/Util.Locale;

    use Basis/Util/Locale.LanguageRange;
    use Basis/Util/Locale.LanguageRange.{LanguageRange};
   


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
        Interop/Util/Locale.newLocale(lang)

    ///
    /// Returns a new Locale for the supplied language and country.
    ///
    pub def newLocaleWithCountry(lang: {lang :: String}, country: {country :: String}): Locale =
        Interop/Util/Locale.newLocaleWithCountry(lang = lang.lang, country = country.country)

    ///
    /// Returns a new Locale for the supplied language, country and variant.
    ///
    /// `variant` is an arbitrary tag to distinguish this Locale from other locales 
    /// representing the same country and language.
    ///
    /// For guidelines to the formatting of a valid tag see the Javadoc for `java.util.Locale`.
    /// 
    pub def newLocaleWithVariant(lang: {lang :: String}, country: {country :: String}, variant: {variant :: String}): Locale =
        Interop/Util/Locale.newLocaleWithVariant(lang = lang.lang, country = country.country, variant = variant.variant)



    pub def setJvmDefaultLocale!(loc: Locale): Result[Unit, String] \ IO =
        Interop/Util/Locale.setJvmDefaultLocale!(loc)

    pub def setJvmDefaultLocaleWithCategory!(category: Category, loc: Locale): Result[Unit, String] \ IO =
        Interop/Util/Locale.setJvmDefaultLocaleWithCategory!(category, loc)

    ///
    /// Returns the "root" locale.
    /// 
    /// The root locale has empty string for country, language and variant.
    ///
    pub def root(): Locale =
        Interop/Util/Locale.root()

    ///
    /// Returns the locale for country Canada with language English.
    /// 
    pub def canada(): Locale =
        Interop/Util/Locale.canada()

    ///
    /// Returns the locale for country Canada with language French.
    /// 
    pub def canada_french(): Locale =
        Interop/Util/Locale.canada_french()

    pub def china(): Locale =
        Interop/Util/Locale.china()

    pub def chinese(): Locale =
        Interop/Util/Locale.chinese()

    pub def english(): Locale =
        Interop/Util/Locale.english()

    pub def france(): Locale =
        Interop/Util/Locale.france()

    pub def french(): Locale =
        Interop/Util/Locale.french()

    pub def german(): Locale =
        Interop/Util/Locale.german()

    pub def germany(): Locale =
        Interop/Util/Locale.germany()

    pub def italian(): Locale =
        Interop/Util/Locale.italian()

    pub def italy(): Locale =
        Interop/Util/Locale.italy()

    pub def japan(): Locale =
        Interop/Util/Locale.japan()

    pub def japanese(): Locale =
        Interop/Util/Locale.japanese()

    pub def korea(): Locale =
        Interop/Util/Locale.korea()

    pub def korean(): Locale =
        Interop/Util/Locale.korean()

    pub def prc(): Locale =
        Interop/Util/Locale.prc()

    pub def simplified_chinese(): Locale =
        Interop/Util/Locale.simplified_chinese()

    pub def taiwan(): Locale =
        Interop/Util/Locale.taiwan()

    pub def traditional_chinese(): Locale =
        Interop/Util/Locale.traditional_chinese()

    pub def uk(): Locale =
        Interop/Util/Locale.uk()

    pub def us(): Locale =
        Interop/Util/Locale.us()


    pub def getDefault(): Locale \ IO =
        Interop/Util/Locale.getDefault()

    pub def getDefaultWithCategory(cat: Category): Locale \ IO =
        Interop/Util/Locale.getDefaultWithCategory(cat)

    pub def getCountry(loc: Locale): String =
        Interop/Util/Locale.getCountry(loc)

    pub def getLanguage(loc: Locale): String =
        Interop/Util/Locale.getLanguage(loc)

    pub def getScript(loc: Locale): String =
        Interop/Util/Locale.getScript(loc)

    pub def getISO3Country(loc: Locale): Option[String] =
        Interop/Util/Locale.getISO3Country(loc) |> Result.toOption

    pub def getISO3Language(loc: Locale): Option[String] =
        Interop/Util/Locale.getISO3Language(loc) |> Result.toOption

    pub def getDisplayCountry(loc: Locale): String =
        Interop/Util/Locale.getDisplayCountry(loc)

    pub def getDisplayCountryWithLocale(inLocale: {inLocale :: Locale}, loc: Locale): String =
        Interop/Util/Locale.getDisplayCountryWithLocale(inLocale = inLocale.inLocale, loc)

    pub def getDisplayLanguage(loc: Locale): String =
        Interop/Util/Locale.getDisplayLanguage(loc)


    pub def getDisplayLanguageWithLocale(inLocale: {inLocale :: Locale}, loc: Locale): String =
        Interop/Util/Locale.getDisplayLanguageWithLocale(inLocale = inLocale.inLocale, loc)

    pub def getDisplayName(loc: Locale): String =
        Interop/Util/Locale.getDisplayName(loc)

    pub def getDisplayNameWithLocale(inLocale: {inLocale :: Locale}, loc: Locale): String =
        Interop/Util/Locale.getDisplayNameWithLocale(inLocale = inLocale.inLocale, loc)

    pub def getDisplayScript(loc: Locale): String =
        Interop/Util/Locale.getDisplayScript(loc)

    pub def getDisplayScriptWithLocale(inLocale: {inLocale :: Locale}, loc: Locale): String =
        Interop/Util/Locale.getDisplayScriptWithLocale(inLocale = inLocale.inLocale, loc)


    pub def getDisplayVariant(loc: Locale): String =
        Interop/Util/Locale.getDisplayVariant(loc)

    pub def getDisplayVariantWithLocale(inLocale: {inLocale :: Locale}, loc: Locale): String =
        Interop/Util/Locale.getDisplayVariantWithLocale(inLocale = inLocale.inLocale, loc)

    pub def hasExtensions(loc: Locale): Bool =
        Interop/Util/Locale.hasExtensions(loc)

    pub def stripExtensions(loc: Locale): Locale =
        Interop/Util/Locale.stripExtensions(loc)


    pub def toLanguageTag(loc: Locale): String =
        Interop/Util/Locale.toLanguageTag(loc)

    pub def forLanguageTag(tag: String): Locale =
        Interop/Util/Locale.forLanguageTag(tag)



    pub def getAvailableLocales(): List[Locale] \ IO =
        Interop/Util/Locale.getAvailableLocales()

    pub def getIsoCountries(): List[String] =
        Interop/Util/Locale.getIsoCountries()

    pub def getIsoCountriesWithIsoCountryCode(icc: IsoCountryCode): Result[Set[String], String] =
        Interop/Util/Locale.getIsoCountriesWithIsoCountryCode(icc)

    pub def getIsoLanguages(): Result[List[String], String] =
        Interop/Util/Locale.getIsoLanguages()

    pub def getExtension(key: Char, loc: Locale): Option[String] =
        Interop/Util/Locale.getExtension(key, loc) |> Result.toOption

    pub def getExtensionKeys(loc: Locale): Set[Char] =
        Interop/Util/Locale.getExtensionKeys(loc)


    pub def getUnicodeLocaleAttributes(loc: Locale): Set[String] =
        Interop/Util/Locale.getUnicodeLocaleAttributes(loc)

    pub def getUnicodeLocaleKeys(loc: Locale): Set[String] =
        Interop/Util/Locale.getUnicodeLocaleKeys(loc)

    pub def lookup(priorityList: List[LanguageRange], locales: List[Locale]): Option[Locale] = 
        let ps = List.map(Basis/Util/Locale/LanguageRange.getLanguageRange, priorityList);
        Interop/Util/Locale.lookup(ps, locales) 
            |> Result.getWithDefault(None) 


    pub def lookupTag(priorityList: List[LanguageRange], tags: List[String]): Option[String] = 
        let ps = List.map(Basis/Util/Locale/LanguageRange.getLanguageRange, priorityList);
        Interop/Util/Locale.lookupTag(ps, tags)
            |> Result.getWithDefault(None)

    pub def filter(priorityList: List[LanguageRange], locales: List[Locale]): List[Locale] = 
        let ps = List.map(Basis/Util/Locale/LanguageRange.getLanguageRange, priorityList);
        Interop/Util/Locale.filter(ps, locales) 
            |> Result.getWithDefault(Nil)

    pub def filterWithFilteringMode(priorityList: List[LanguageRange], mode: FilteringMode, locales: List[Locale]): List[Locale] = 
        let ps = List.map(Basis/Util/Locale/LanguageRange.getLanguageRange, priorityList);
        Interop/Util/Locale.filterWithFilteringMode(ps, mode, locales) 
            |> Result.getWithDefault(Nil)

    pub def filterTags(priorityList: List[LanguageRange], tags: List[String]): List[String] = 
        let ps = List.map(Basis/Util/Locale/LanguageRange.getLanguageRange, priorityList);
        Interop/Util/Locale.filterTags(ps, tags) |> Result.getWithDefault(Nil)

    pub def filterTagsWithFilteringMode(priorityList: List[LanguageRange], mode: FilteringMode, tags: List[String]): List[String] = 
        let ps = List.map(Basis/Util/Locale/LanguageRange.getLanguageRange, priorityList);
        Interop/Util/Locale.filterTagsWithFilteringMode(ps, mode, tags) |> Result.getWithDefault(Nil)


}
