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

mod Basis.Util {

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
    pub type alias Locale = Interop.Util.Locale


}



mod Basis.Util.Locale {

    use Basis.Util.Locale
    use Basis.Util.Locale.Category
    use Basis.Util.Locale.Category.{Display, Format}
    use Basis.Util.Locale.FilteringMode
    use Basis.Util.Locale.FilteringMode.{
        AutoselectFiltering, ExtendedFiltering,
        IgnoreExtendedRanges, MapExtendedRanges, 
        RejectExtendedRanges
    }
    use Basis.Util.Locale.IsoCountryCode
    use Basis.Util.Locale.IsoCountryCode.{
        Part1Alpha2, Part1Alpha3, Part3
    }
    use Basis.Util.Locale.LanguageRange
    

    /// 
    /// `Category` is an enum for Locale categories.
    /// 
    /// Case `Display` represents the default locale for displaying user interfaces.
    ///
    /// Case `Format` represents the default locale for formatting dates / times / numbers etc.
    ///
    pub enum Category with Eq, Order, Hash, ToString {
        case Display
        case Format
    }


    pub enum FilteringMode with Eq, Order, Hash, ToString {
        case AutoselectFiltering
        case ExtendedFiltering
        case IgnoreExtendedRanges
        case MapExtendedRanges
        case RejectExtendedRanges
    }

    pub enum IsoCountryCode with Eq, Order, Hash, ToString {
        case Part1Alpha2
        case Part1Alpha3
        case Part3
    }


    pub def marshalCategory(x: Category): Interop.Util.LocaleCategory = match x {
        case Display    => Interop.Util.LocaleCategory.display()
        case Format     => Interop.Util.LocaleCategory.format()
    }

    pub def marshalFilteringMode(x: FilteringMode): Interop.Util.LocaleFilteringMode = match x {
        case AutoselectFiltering    => Interop.Util.LocaleFilteringMode.autoselect_filtering()
        case ExtendedFiltering      => Interop.Util.LocaleFilteringMode.extended_filtering()
        case IgnoreExtendedRanges   => Interop.Util.LocaleFilteringMode.ignore_extended_ranges()
        case MapExtendedRanges      => Interop.Util.LocaleFilteringMode.map_extended_ranges()
        case RejectExtendedRanges   => Interop.Util.LocaleFilteringMode.reject_extended_ranges()
    }

    pub def marshalIsoCountryCode(x: IsoCountryCode): Interop.Util.LocaleIsoCountryCode = match x {
        case Part1Alpha2    => Interop.Util.LocaleIsoCountryCode.part1_alpha2()
        case Part1Alpha3    => Interop.Util.LocaleIsoCountryCode.part1_alpha3()
        case Part3          => Interop.Util.LocaleIsoCountryCode.part3()
    }


    ///
    /// Returns a new Locale for the supplied language.
    ///
    pub def newLocale(lang: String): Locale =
        Interop.Util.Locale.newLocale(lang)

    ///
    /// Returns a new Locale for the supplied language and country.
    ///
    pub def newLocaleWithCountry(lang: {lang = String}, country: {country = String}): Locale =
        Interop.Util.Locale.newLocaleWithCountry(lang = lang.lang, country = country.country)

    ///
    /// Returns a new Locale for the supplied language, country and variant.
    ///
    /// `variant` is an arbitrary tag to distinguish this Locale from other locales 
    /// representing the same country and language.
    ///
    /// For guidelines to the formatting of a valid tag see the Javadoc for `java.util.Locale`.
    /// 
    pub def newLocaleWithVariant(lang: {lang = String}, country: {country = String}, variant: {variant = String}): Locale =
        Interop.Util.Locale.newLocaleWithVariant(lang = lang.lang, country = country.country, variant = variant.variant)



    pub def setJvmDefaultLocale!(loc: Locale): Result[String, Unit] \ IO =
        Interop.Util.Locale.setJvmDefaultLocale!(loc)

    pub def setJvmDefaultLocaleWithCategory!(category: Category, loc: Locale): Result[String, Unit] \ IO =
        let category1 = marshalCategory(category);
        Interop.Util.Locale.setJvmDefaultLocaleWithCategory!(category1, loc)

    ///
    /// Returns the "root" locale.
    /// 
    /// The root locale has empty string for country, language and variant.
    ///
    pub def root(): Locale =
        Interop.Util.Locale.root()

    ///
    /// Returns the locale for country Canada with language English.
    /// 
    pub def canada(): Locale =
        Interop.Util.Locale.canada()

    ///
    /// Returns the locale for country Canada with language French.
    /// 
    pub def canada_french(): Locale =
        Interop.Util.Locale.canada_french()

    pub def china(): Locale =
        Interop.Util.Locale.china()

    pub def chinese(): Locale =
        Interop.Util.Locale.chinese()

    pub def english(): Locale =
        Interop.Util.Locale.english()

    pub def france(): Locale =
        Interop.Util.Locale.france()

    pub def french(): Locale =
        Interop.Util.Locale.french()

    pub def german(): Locale =
        Interop.Util.Locale.german()

    pub def germany(): Locale =
        Interop.Util.Locale.germany()

    pub def italian(): Locale =
        Interop.Util.Locale.italian()

    pub def italy(): Locale =
        Interop.Util.Locale.italy()

    pub def japan(): Locale =
        Interop.Util.Locale.japan()

    pub def japanese(): Locale =
        Interop.Util.Locale.japanese()

    pub def korea(): Locale =
        Interop.Util.Locale.korea()

    pub def korean(): Locale =
        Interop.Util.Locale.korean()

    pub def prc(): Locale =
        Interop.Util.Locale.prc()

    pub def simplified_chinese(): Locale =
        Interop.Util.Locale.simplified_chinese()

    pub def taiwan(): Locale =
        Interop.Util.Locale.taiwan()

    pub def traditional_chinese(): Locale =
        Interop.Util.Locale.traditional_chinese()

    pub def uk(): Locale =
        Interop.Util.Locale.uk()

    pub def us(): Locale =
        Interop.Util.Locale.us()


    pub def getDefault(): Locale \ IO =
        Interop.Util.Locale.getDefault()

    pub def getDefaultWithCategory(cat: Category): Locale \ IO =
        marshalCategory(cat) |> Interop.Util.Locale.getDefaultWithCategory

    pub def getCountry(loc: Locale): String =
        Interop.Util.Locale.getCountry(loc)

    pub def getLanguage(loc: Locale): String =
        Interop.Util.Locale.getLanguage(loc)

    pub def getScript(loc: Locale): String =
        Interop.Util.Locale.getScript(loc)

    pub def getISO3Country(loc: Locale): Option[String] =
        Interop.Util.Locale.getISO3Country(loc) |> Result.toOption

    pub def getISO3Language(loc: Locale): Option[String] =
        Interop.Util.Locale.getISO3Language(loc) |> Result.toOption

    pub def getDisplayCountry(loc: Locale): String =
        Interop.Util.Locale.getDisplayCountry(loc)

    pub def getDisplayCountryWithLocale(inLocale: {inLocale = Locale}, loc: Locale): String =
        Interop.Util.Locale.getDisplayCountryWithLocale(inLocale = inLocale.inLocale, loc)

    pub def getDisplayLanguage(loc: Locale): String =
        Interop.Util.Locale.getDisplayLanguage(loc)


    pub def getDisplayLanguageWithLocale(inLocale: {inLocale = Locale}, loc: Locale): String =
        Interop.Util.Locale.getDisplayLanguageWithLocale(inLocale = inLocale.inLocale, loc)

    pub def getDisplayName(loc: Locale): String =
        Interop.Util.Locale.getDisplayName(loc)

    pub def getDisplayNameWithLocale(inLocale: {inLocale = Locale}, loc: Locale): String =
        Interop.Util.Locale.getDisplayNameWithLocale(inLocale = inLocale.inLocale, loc)

    pub def getDisplayScript(loc: Locale): String =
        Interop.Util.Locale.getDisplayScript(loc)

    pub def getDisplayScriptWithLocale(inLocale: {inLocale = Locale}, loc: Locale): String =
        Interop.Util.Locale.getDisplayScriptWithLocale(inLocale = inLocale.inLocale, loc)


    pub def getDisplayVariant(loc: Locale): String =
        Interop.Util.Locale.getDisplayVariant(loc)

    pub def getDisplayVariantWithLocale(inLocale: {inLocale = Locale}, loc: Locale): String =
        Interop.Util.Locale.getDisplayVariantWithLocale(inLocale = inLocale.inLocale, loc)

    pub def hasExtensions(loc: Locale): Bool =
        Interop.Util.Locale.hasExtensions(loc)

    pub def stripExtensions(loc: Locale): Locale =
        Interop.Util.Locale.stripExtensions(loc)


    pub def toLanguageTag(loc: Locale): String =
        Interop.Util.Locale.toLanguageTag(loc)

    pub def forLanguageTag(tag: String): Locale =
        Interop.Util.Locale.forLanguageTag(tag)



    pub def getAvailableLocales(): List[Locale] \ IO =
        Interop.Util.Locale.getAvailableLocales()

    pub def getIsoCountries(): List[String] =
        Interop.Util.Locale.getIsoCountries()

    pub def getIsoCountriesWithIsoCountryCode(icc: IsoCountryCode): Result[String, Set[String]] =
        marshalIsoCountryCode(icc) 
            |> Interop.Util.Locale.getIsoCountriesWithIsoCountryCode

    pub def getIsoLanguages(): Result[String, List[String]] =
        Interop.Util.Locale.getIsoLanguages()

    pub def getExtension(key: Char, loc: Locale): Option[String] =
        Interop.Util.Locale.getExtension(key, loc) |> Result.toOption

    pub def getExtensionKeys(loc: Locale): Set[Char] =
        Interop.Util.Locale.getExtensionKeys(loc)


    pub def getUnicodeLocaleAttributes(loc: Locale): Set[String] =
        Interop.Util.Locale.getUnicodeLocaleAttributes(loc)

    pub def getUnicodeLocaleKeys(loc: Locale): Set[String] =
        Interop.Util.Locale.getUnicodeLocaleKeys(loc)

    pub def lookup(priorityList: List[LanguageRange], locales: List[Locale]): Option[Locale] = 
        Interop.Util.Locale.lookup(priorityList, locales) 
            |> Result.getWithDefault(None) 


    pub def lookupTag(priorityList: List[LanguageRange], tags: List[String]): Option[String] = 
        Interop.Util.Locale.lookupTag(priorityList, tags)
            |> Result.getWithDefault(None)

    pub def filter(priorityList: List[LanguageRange], locales: List[Locale]): List[Locale] = 
        Interop.Util.Locale.filter(priorityList, locales) 
            |> Result.getWithDefault(Nil)

    pub def filterWithFilteringMode(priorityList: List[LanguageRange], mode: FilteringMode, locales: List[Locale]): List[Locale] = 
        let mode1 = marshalFilteringMode(mode);
        Interop.Util.Locale.filterWithFilteringMode(priorityList, mode1, locales) |> Result.getWithDefault(Nil)

    pub def filterTags(priorityList: List[LanguageRange], tags: List[String]): List[String] = 
        Interop.Util.Locale.filterTags(priorityList, tags) |> Result.getWithDefault(Nil)

    pub def filterTagsWithFilteringMode(priorityList: List[LanguageRange], mode: FilteringMode, tags: List[String]): List[String] =
        let mode1 = marshalFilteringMode(mode);
        Interop.Util.Locale.filterTagsWithFilteringMode(priorityList, mode1, tags) |> Result.getWithDefault(Nil)


}
