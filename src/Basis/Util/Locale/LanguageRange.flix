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

mod Basis.Util.Locale {

    /// 
    pub type alias LanguageRange = Interop.Util.Locale.LanguageRange



}


mod Basis.Util.Locale.LanguageRange {

    use Basis.Util.Locale.LanguageRange
    
    

    ///
    /// Returns a new LanguageRange for the supplied `range`.
    ///
    pub def new(range: String): Result[String, LanguageRange] =
        Interop.Util.Locale.LanguageRange.new(range) 

    pub def maxWeight(): Float64 =
        Interop.Util.Locale.LanguageRange.maxWeight()

    pub def minWeight(): Float64 =
        Interop.Util.Locale.LanguageRange.minWeight()

    pub def getRange(rng: LanguageRange): String =
        Interop.Util.Locale.LanguageRange.getRange(rng)


    pub def getWeight(rng: LanguageRange): Float64 =
        Interop.Util.Locale.LanguageRange.getWeight(rng)


    pub def parse(ranges: String): Result[String, List[LanguageRange]] =
        Interop.Util.Locale.LanguageRange.parse(ranges) 

    pub def parseWithCustomizations(ranges: String, customizations: Map[String, List[String]]): Result[String, List[LanguageRange]] =
        Interop.Util.Locale.LanguageRange.parseWithCustomizations(ranges, customizations) 


    pub def mapEquivalents(priorityList: List[LanguageRange], customizations: Map[String, List[String]]): Result[String, List[LanguageRange]] =
        Interop.Util.Locale.LanguageRange.mapEquivalents(priorityList, customizations) 



}   
