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

namespace Basis/Text {
    
    /// Treat as immutable
    /// Represents a DecimalFormat.
    ///
    pub enum DecimalFormat(##java.text.DecimalFormat)

}


namespace Basis/Text/DecimalFormat {

    use Basis/Text.DecimalFormat;
    use Basis/Text.DecimalFormat.{DecimalFormat};
    use Basis/I18n.Locale;
    use Basis/I18n.Currency;

    def toInteropDecimalFormat(r: Region[r], df: DecimalFormat): Interop/Text.DecimalFormat[r] = 
        let DecimalFormat(df1) = df;
        Interop/Text/DecimalFormat.wrapHH(r, df1)



    pub def hashCode(df: DecimalFormat): Int32 = region r {
        toInteropDecimalFormat(r, df) |> Interop/Text/DecimalFormat.hashCode
    }

    pub def formatFloat64(d: Float64, df: DecimalFormat): Result[String, String] = region r {
        toInteropDecimalFormat(r, df) |> Interop/Text/NumberFormat.formatFloat64(d)
    }

    pub def formatInt64(i: Int64, df: DecimalFormat): Result[String, String] = region r {
        toInteropDecimalFormat(r, df) |> Interop/Text/NumberFormat.formatInt64(i)
    }

    pub def parseInt8(s: String, df: DecimalFormat): Result[Int8, String] = region r {
        toInteropDecimalFormat(r, df) 
            |> Interop/Text/NumberFormat.parse(s)
            |> Result.map(Interop/Lang/Number.byteValue)
    }

    pub def parseInt16(s: String, df: DecimalFormat): Result[Int16, String] = region r {
        toInteropDecimalFormat(r, df) 
            |> Interop/Text/NumberFormat.parse(s)
            |> Result.map(Interop/Lang/Number.shortValue)
    }

    pub def parseInt32(s: String, df: DecimalFormat): Result[Int32, String] = region r {
        toInteropDecimalFormat(r, df) 
            |> Interop/Text/NumberFormat.parse(s)
            |> Result.map(Interop/Lang/Number.intValue)
    }

    pub def parseInt64(s: String, df: DecimalFormat): Result[Int64, String] = region r {
        toInteropDecimalFormat(r, df) 
            |> Interop/Text/NumberFormat.parse(s)
            |> Result.map(Interop/Lang/Number.longValue)
    }

    pub def parseFloat32(s: String, df: DecimalFormat): Result[Float32, String] = region r {
        toInteropDecimalFormat(r, df) 
            |> Interop/Text/NumberFormat.parse(s)
            |> Result.map(Interop/Lang/Number.floatValue)
    }

    pub def parseFloat64(s: String, df: DecimalFormat): Result[Float64, String] = region r {
        toInteropDecimalFormat(r, df) 
            |> Interop/Text/NumberFormat.parse(s)
            |> Result.map(Interop/Lang/Number.doubleValue)
    }

    ///
    pub def toPattern(df: DecimalFormat): String = region r {
        toInteropDecimalFormat(r, df) |> Interop/Text/DecimalFormat.toPattern
    }


    ///
    pub def toLocalizedPattern(df: DecimalFormat): String = region r {
        toInteropDecimalFormat(r, df) |> Interop/Text/DecimalFormat.toLocalizedPattern
    }

    pub def getCurrency(df: DecimalFormat): Result[Currency, String] = region r {
        toInteropDecimalFormat(r, df) |> Interop/Text/DecimalFormat.getCurrency
    }


}
