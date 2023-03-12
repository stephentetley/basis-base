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

namespace Basis/Util/Locale {

    pub type alias Builder = Interop/Util.LocaleBuilder

}


namespace Basis/Util/Locale/Builder {

    use Basis/Util/Locale.Builder
    use Basis/Util.Locale
    use Interop/Util/LocaleBuilder.LocaleBuilderAction

    pub def buildLocale(xs: List[LocaleBuilderAction]): Result[String, Locale] =
        Interop/Util/LocaleBuilder.buildLocale(xs)

    pub def addUnicodeLocaleAttribute(attr: String): LocaleBuilderAction = 
        use Interop/Util/LocaleBuilder.LocaleBuilderAction.{AddUnicodeLocaleAttribute};
        AddUnicodeLocaleAttribute(attr)

    pub def clear(): LocaleBuilderAction = 
        use Interop/Util/LocaleBuilder.LocaleBuilderAction.{Clear};
        Clear()

    pub def clearExtensions(): LocaleBuilderAction = 
        use Interop/Util/LocaleBuilder.LocaleBuilderAction.{Clear};
        Clear()

    pub def removeUnicodeLocaleAttribute(attr: String): LocaleBuilderAction = 
        use Interop/Util/LocaleBuilder.LocaleBuilderAction.{RemoveUnicodeLocaleAttribute};
        RemoveUnicodeLocaleAttribute(attr)

    pub def setExtension(k: Char, v: String): LocaleBuilderAction =  
        use Interop/Util/LocaleBuilder.LocaleBuilderAction.{SetExtension};
        SetExtension(k, v)

    pub def setUnicodeLocaleKeyword(k: String, ty: String): LocaleBuilderAction = 
        use Interop/Util/LocaleBuilder.LocaleBuilderAction.{SetUnicodeLocaleKeyword};
        SetUnicodeLocaleKeyword(k, ty)

    pub def setLanguage(lang: String): LocaleBuilderAction =  
        use Interop/Util/LocaleBuilder.LocaleBuilderAction.{SetLanguage};
        SetLanguage(lang)

    pub def setLanguageTag(tag: String): LocaleBuilderAction = 
        use Interop/Util/LocaleBuilder.LocaleBuilderAction.{SetLanguageTag};
        SetLanguageTag(tag) 

    pub def setLocale(loc: Locale): LocaleBuilderAction =  
        use Interop/Util/LocaleBuilder.LocaleBuilderAction.{SetLocale};
        SetLocale(loc)

    pub def setRegion(rgn: String): LocaleBuilderAction =  
        use Interop/Util/LocaleBuilder.LocaleBuilderAction.{SetRegion};
        SetRegion(rgn)

    pub def setScript(script: String): LocaleBuilderAction =  
        use Interop/Util/LocaleBuilder.LocaleBuilderAction.{SetScript};
        SetScript(script)

    pub def setVariant(vrnt: String): LocaleBuilderAction = 
        use Interop/Util/LocaleBuilder.LocaleBuilderAction.{SetVariant};
        SetVariant(vrnt)


}   
