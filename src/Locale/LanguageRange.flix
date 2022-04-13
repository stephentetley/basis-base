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

namespace Locale {

    pub opaque type LanguageRange = ##java.util.Locale$LanguageRange

    instance ToString[LanguageRange] {
        pub def toString(x: LanguageRange): String = Locale/LanguageRange.toString(x)
    }

    instance Eq[LanguageRange] {
        pub def eq(x: LanguageRange, y: LanguageRange): Bool = Locale/LanguageRange.equals(x, y)
    }

    instance Hash[LanguageRange] {
        pub def hash(x: LanguageRange): Int32 = Locale/LanguageRange.hashCode(x)
    }

}


namespace Locale/LanguageRange {

    use Locale.LanguageRange;
    use Locale.LanguageRange.{LanguageRange};


    ///
    /// Returns a new LanguageRange for the supplied `range`.
    ///
    pub def newLanguageRange(range: String): Option[LanguageRange] =
        import new java.util.Locale$LanguageRange(String): ##java.util.Locale$LanguageRange & Pure as new1;
        try {
            Some(LanguageRange(new1(range)))
        } catch {
            case _: ##java.lang.IllegalArgumentException => None
        }

    pub def equals(x: LanguageRange, y: LanguageRange): Bool =
        import java.util.Locale$LanguageRange.equals(##java.lang.Object): Bool & Pure;
        let LanguageRange(x1) = x;
        let LanguageRange(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def toString(x: LanguageRange): String =
        import java.util.Locale$LanguageRange.toString(): String & Pure;
        let LanguageRange(x1) = x;
        toString(x1)

    pub def hashCode(x: LanguageRange): Int32 =
        import java.util.Locale$LanguageRange.hashCode(): Int32 & Pure;
        let LanguageRange(x1) = x;
        hashCode(x1)

    pub def maxWeight(): Float64 =
        import static get java.util.Locale$LanguageRange.MAX_WEIGHT: Float64 & Pure as get_MAX_WEIGHT;
        get_MAX_WEIGHT()

    pub def minWeight(): Float64 =
        import static get java.util.Locale$LanguageRange.MIN_WEIGHT: Float64 & Pure as get_MIN_WEIGHT;
        get_MIN_WEIGHT()

    pub def getRange(x: LanguageRange): String =
        import java.util.Locale$LanguageRange.getRange(): String & Pure;
        let LanguageRange(x1) = x;
        getRange(x1)

    pub def getWeight(x: LanguageRange): Float64 =
        import java.util.Locale$LanguageRange.getWeight(): Float64 & Pure;
        let LanguageRange(x1) = x;
        getWeight(x1)


    pub def parse(ranges: String): Result[List[LanguageRange], String] =
        import static java.util.Locale$LanguageRange.parse(String): ##java.util.List & Pure;
        try {
            let jxs = parse(ranges);
            let xs = Marshal.unmarshalList(obj -> LanguageRange(obj as ##java.util.Locale$LanguageRange), jxs) as & Pure;
            Ok(xs)
        } catch {
            case _: ##java.lang.IllegalArgumentException => Err("Ill-formed range/weight list")
        }

    /// mapEquivalents, parse(2)

}   
