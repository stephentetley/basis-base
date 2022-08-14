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

namespace Basis/I18n/Locale {

    pub enum LanguageRange(Interop/Util/Locale.LanguageRange)

    instance ToString[LanguageRange] {
        pub def toString(rng: LanguageRange): String = 
            let LanguageRange(rng1) = rng;
            Interop/Util/Locale/LanguageRange.toString(rng1)
    }

    instance Eq[LanguageRange] {
        pub def eq(x: LanguageRange, y: LanguageRange): Bool = 
            let LanguageRange(x1) = x;
            let LanguageRange(y1) = y;
            Interop/Util/Locale/LanguageRange.equals(x1, y1)
    }

    instance Hash[LanguageRange] {
        pub def hash(rng: LanguageRange): Int32 = 
            let LanguageRange(rng1) = rng;
            Interop/Util/Locale/LanguageRange.hashCode(rng1)
    }

    instance Interop/Flix.Marshal[LanguageRange] {
        pub def toJavaObject(rng: LanguageRange): ##java.lang.Object = 
            let LanguageRange(rng1) = rng;
            Interop/Flix/Marshal.toJavaObject(rng1)
        
        pub def fromJavaObject(o: ##java.lang.Object): LanguageRange = 
            LanguageRange(Interop/Flix/Marshal.fromJavaObject(o))
    }

}


namespace Basis/I18n/Locale/LanguageRange {

    use Basis/I18n/Locale.LanguageRange;
    use Basis/I18n/Locale.LanguageRange.{LanguageRange};

    pub def getLanguageRange(rng: LanguageRange): Interop/Util/Locale.LanguageRange = 
        let LanguageRange(rng1) = rng;
        rng1


    ///
    /// Returns a new LanguageRange for the supplied `range`.
    ///
    pub def newLanguageRange(range: String): Option[LanguageRange] =
        Interop/Util/Locale/LanguageRange.newLanguageRange(range) 
            |> Result.map(LanguageRange)
            |> Result.toOption

    pub def maxWeight(): Float64 =
        Interop/Util/Locale/LanguageRange.maxWeight()

    pub def minWeight(): Float64 =
        Interop/Util/Locale/LanguageRange.minWeight()

    pub def getRange(rng: LanguageRange): String =
        getLanguageRange(rng) |> Interop/Util/Locale/LanguageRange.getRange


    pub def getWeight(rng: LanguageRange): Float64 =
        getLanguageRange(rng) |> Interop/Util/Locale/LanguageRange.getWeight


    pub def parse(ranges: String): Result[List[LanguageRange], String] =
        Interop/Util/Locale/LanguageRange.parse(ranges) 
            |> Result.map(List.map(LanguageRange))

    pub def parseWithCustomizations(ranges: String, customizations: Map[String, List[String]]): Result[List[LanguageRange], String] =
        Interop/Util/Locale/LanguageRange.parseWithCustomizations(ranges, customizations) 
            |> Result.map(List.map(LanguageRange))

    pub def mapEquivalents(priorityList: List[LanguageRange], customizations: Map[String, List[String]]): Result[List[LanguageRange], String] =
        let ps = List.map(getLanguageRange, priorityList);
        Interop/Util/Locale/LanguageRange.mapEquivalents(ps, customizations) 
            |> Result.map(List.map(LanguageRange))


}   
