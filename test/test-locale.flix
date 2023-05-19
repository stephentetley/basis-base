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

mod TestLocale { 

    use GradedApplicative.{*>}

    @test
    def getIsoCountries01(): Unit \ IO = 
        Basis.Util.Locale.getIsoCountries() |> List.forEach(println)


    @test
    def getIsoCountriesWithIsoCountryCode01(): Unit \ IO = 
        match Basis.Util.Locale.getIsoCountriesWithIsoCountryCode(Basis.Util.Locale.IsoCountryCode.Part1Alpha2) {
            case Ok(s) => Set.forEach(println, s) 
            case Err(msg) => println("Err: ${msg}")
        }


    @test
    def test03(): Unit \ IO = 
        match Basis.Util.Locale.getIsoLanguages() {
            case Ok(l) => List.forEach(println, l) 
            case Err(msg) => println("Err: ${msg}")
        }


    @test
    def test04(): Unit \ IO = 
        Basis.Util.Locale.getAvailableLocales()
            |> List.forEach(println) 


    @test
    def testCanada(): Unit \ IO = 
        let l1 = Basis.Util.Locale.canada();
        println("Canada: ${l1}");
        ()


    @test
    def getUnicodeLocaleAttributes01(): Unit \ IO =
        let l1 = Basis.Util.Locale.japan();
        Basis.Util.Locale.getUnicodeLocaleAttributes(l1) 
            |> Set.forEach(x1 -> println("Attr: ${x1}"))

    @test
    def getUnicodeLocaleKeys01(): Unit \ IO =
        let l1 = Basis.Util.Locale.japan();
        Basis.Util.Locale.getUnicodeLocaleKeys(l1) 
            |> Set.forEach(x1 -> println("Key: ${x1}"))

    @test
    def lookup01(): Unit \ IO =
        println("TestLocale.lookup01...");
        let ls = Basis.Util.Locale.japan() :: Basis.Util.Locale.french() :: Basis.Util.Locale.english() :: Nil;
        match Basis.Util.Locale.LanguageRange.new("en") {
            case Err(msg) => println("Err: ${msg}")
            case Ok(p1) => println("lookup: ${Basis.Util.Locale.lookup(p1 :: Nil, ls)}")
        }

    @test
    def builder01(): Unit \ IO = region rc {
        use Basis.Util.LocaleBuilder.{buildLocale, setLanguage!};
        println("TestLocale.builder01...");
        match buildLocale(rc, setLanguage!("da")) {
            case Err(msg) => println("Err: ${msg}")
            case Ok(loc)  => println("locale is: ${loc}")
        }
    }

    @test
    def builder02(): Unit \ IO = region rc {
        use GradedApplicative.{*>};
        use Basis.Util.LocaleBuilder.{buildLocale, setLanguage!, setScript!};
        println("TestLocale.builder02...");
        match buildLocale(rc, setLanguage!("da") *> setScript!("Latn")) {
            case Err(msg) => println("Err: ${msg}")
            case Ok(loc)  => println("locale is: ${loc}")
        }
    }

    @test
    def builder03(): Unit \ IO = region rc {
        use GradedApplicative.{*>};
        use Basis.Util.LocaleBuilder.{buildLocale, setLanguage!, setScript!, setRegion!};
        println("TestLocale.builder03... expect Err");
        match buildLocale(rc, setLanguage!("da") *> setScript!("Latn") *> setRegion!("BAD_REGION")) {
            case Err(msg) => println("Err: ${msg}")
            case Ok(loc)  => println("locale is: ${loc}")
        } 
    }

}
