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

mod Basis.Util {

    pub type alias LocaleBuilder[ka: Type, r: Region, ef: Eff, a: Type] = Graded.Builder[ka, Interop.Util.LocaleBuilder[r], ef, a]

}


mod Basis.Util.LocaleBuilder {

    use Basis.Util.LocaleBuilder
    use Basis.Util.Locale
    use Graded.Builder.{liftSetter!, liftSetterResult!}

    pub def buildLocale(rc: Region[r], ma: LocaleBuilder[a, r, ef, a]): Result[String, Locale] \ {ef, r} =
        let lb = Interop.Util.LocaleBuilder.new(rc);
        Graded.Builder.runBuilder(ma, lb) |> Result.map(_ -> Interop.Util.LocaleBuilder.build(lb))


    pub def addUnicodeLocaleAttribute!(attr: String): LocaleBuilder[ka, r, r, Unit] = 
        use Interop.Util.LocaleBuilder.{addUnicodeLocaleAttribute!};
        liftSetterResult!(addUnicodeLocaleAttribute!(attr)) |> GradedFunctor.ignore

    pub def clear(): LocaleBuilder[ka, r, r, Unit] = 
        use Interop.Util.LocaleBuilder.{clear!};
        liftSetter!(clear!) |> GradedFunctor.ignore

    pub def clearExtensions!(): LocaleBuilder[ka, r, r, Unit] = 
        use Interop.Util.LocaleBuilder.{clearExtensions!};
        liftSetter!(clearExtensions!) |> GradedFunctor.ignore

    pub def removeUnicodeLocaleAttribute!(attr: String): LocaleBuilder[ka, r, r, Unit] = 
        use Interop.Util.LocaleBuilder.{removeUnicodeLocaleAttribute!};
        liftSetterResult!(removeUnicodeLocaleAttribute!(attr)) |> GradedFunctor.ignore

    pub def setExtension!(k: Char, v: String): LocaleBuilder[ka, r, r, Unit] =  
        use Interop.Util.LocaleBuilder.{setExtension!};
        liftSetterResult!(setExtension!(k, v)) |> GradedFunctor.ignore

    pub def setUnicodeLocaleKeyword!(k: String, ty: String): LocaleBuilder[ka, r, r, Unit] = 
        use Interop.Util.LocaleBuilder.{setUnicodeLocaleKeyword!};
        liftSetterResult!(setUnicodeLocaleKeyword!(k, ty)) |> GradedFunctor.ignore

    pub def setLanguage!(lang: String): LocaleBuilder[ka, r, r, Unit] =  
        use Interop.Util.LocaleBuilder.{setLanguage!};
        liftSetterResult!(setLanguage!(lang)) |> GradedFunctor.ignore

    pub def setLanguageTag!(tag: String): LocaleBuilder[ka, r, r, Unit] = 
        use Interop.Util.LocaleBuilder.{setLanguageTag!};
        liftSetterResult!(setLanguageTag!(tag)) |> GradedFunctor.ignore

    pub def setLocale!(loc: Locale): LocaleBuilder[ka, r, r, Unit] =  
        use Interop.Util.LocaleBuilder.{setLocale!};
        liftSetterResult!(setLocale!(loc)) |> GradedFunctor.ignore

    pub def setRegion!(rgn: String): LocaleBuilder[ka, r, r, Unit] =  
        use Interop.Util.LocaleBuilder.{setRegion!};
        liftSetterResult!(setRegion!(rgn)) |> GradedFunctor.ignore

    pub def setScript!(script: String): LocaleBuilder[ka, r, r, Unit] =  
        use Interop.Util.LocaleBuilder.{setScript!};
        liftSetterResult!(setScript!(script)) |> GradedFunctor.ignore

    pub def setVariant!(vrnt: String): LocaleBuilder[ka, r, r, Unit] = 
        use Interop.Util.LocaleBuilder.{setVariant!};
        liftSetterResult!(setVariant!(vrnt)) |> GradedFunctor.ignore


}   
