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

namespace TestLocale { 


@test
def getIsoCountries01(): Unit & Impure = 
    Locale.getIsoCountries() |> Array.foreach(println)


@test
def getIsoCountriesWithIsoCountryCode01(): Unit & Impure = 
    match Locale.getIsoCountriesWithIsoCountryCode(Locale/IsoCountryCode.Part1Alpha2) {
        case Ok(s) => Set.foreach(println, s) 
        case Err(msg) => println("Err: ${msg}")
    }


@test
def test03(): Unit & Impure = 
    match Locale.getIsoLanguages() {
        case Ok(l) => List.foreach(println, l) 
        case Err(msg) => println("Err: ${msg}")
    }


@test
def test04(): Unit & Impure = 
    Locale.getAvailableLocales()
        |> Array.foreach(println) 


@test
def testCanada(): Unit & Impure = 
    let l1 = Locale.canada();
    println("Canada: ${l1}");
    ()


@test
def getUnicodeLocaleAttributes01(): Unit & Impure =
    let l1 = Locale.japan();
    match Locale.getUnicodeLocaleAttributes(l1) { 
        case Ok(s) => Set.foreach(x1 -> println("Attr: ${x1}"), s)
        case Err(msg) => println("Err: ${msg}")
    }

@test
def getUnicodeLocaleKeys01(): Unit & Impure =
    let l1 = Locale.japan();
    match Locale.getUnicodeLocaleKeys(l1) { 
        case Ok(s) => Set.foreach(x1 -> println("Key: ${x1}"), s)
        case Err(msg) => println("Err: ${msg}")
    }

@test
def lookup01(): Unit & Impure =
    println("TestLocale.lookup01...");
    let ls = Locale.japan() :: Locale.french() :: Locale.english() :: Nil;
    match Locale/LanguageRange.newLanguageRange("en") {
        case None     => println("Err: newLanguageRange")
        case Some(p1) => println("lookup: ${Locale.lookup(p1 :: Nil, ls)}")
    }

@test
def builder01(): Unit & Impure =
    use Locale/Builder.{build, setLanguage};
    println("TestLocale.builder01...");
    match build(setLanguage("da")) {
        case Err(msg) => println("Err: ${msg}")
        case Ok(loc)  => println("locale is: ${loc}")
    }

@test
def builder02(): Unit & Impure =
    use Applicative.{*>};
    use Locale/Builder.{build, setLanguage, setScript};
    println("TestLocale.builder02...");
    match build(setLanguage("da") *> setScript("Latn")) {
        case Err(msg) => println("Err: ${msg}")
        case Ok(loc)  => println("locale is: ${loc}")
    }    
}