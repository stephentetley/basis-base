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

mod Basis.Text {
    
    /// Treat as immutable
    /// Represents a DecimalFormat.
    ///
    pub type alias DecimalFormat = Interop.Text.DecimalFormat

}


mod Basis.Text.DecimalFormat {

    use Interop.Text.DecimalFormat.{DecimalFormat}
    
    use Basis.Text.DecimalFormat
    use Basis.Util.Currency



    pub def hashCode(df: DecimalFormat): Int32 =
        Interop.Text.DecimalFormat.hashCode(df)

    pub def formatFloat64(d: Float64, df: DecimalFormat): Result[String, String] =
        Interop.Text.SubNumberFormat.toNumberFormat(df)
            |> Interop.Text.NumberFormat.formatFloat64(d)


    pub def formatInt64(i: Int64, df: DecimalFormat): Result[String, String] =
        Interop.Text.SubNumberFormat.toNumberFormat(df) 
            |> Interop.Text.NumberFormat.formatInt64(i)


    pub def parseInt8(s: String, df: DecimalFormat): Result[String, Int8] = 
        Interop.Text.SubNumberFormat.toNumberFormat(df) 
            |> Interop.Text.NumberFormat.parse(s)
            |> Result.map(Interop.Lang.Number.byteValue)


    pub def parseInt16(s: String, df: DecimalFormat): Result[String, Int16] = 
        Interop.Text.SubNumberFormat.toNumberFormat(df)
            |> Interop.Text.NumberFormat.parse(s)
            |> Result.map(Interop.Lang.Number.shortValue)


    pub def parseInt32(s: String, df: DecimalFormat): Result[String, Int32] =
        Interop.Text.SubNumberFormat.toNumberFormat(df)
            |> Interop.Text.NumberFormat.parse(s)
            |> Result.map(Interop.Lang.Number.intValue)


    pub def parseInt64(s: String, df: DecimalFormat): Result[String, Int64] =
        Interop.Text.SubNumberFormat.toNumberFormat(df)
            |> Interop.Text.NumberFormat.parse(s)
            |> Result.map(Interop.Lang.Number.longValue)


    pub def parseFloat32(s: String, df: DecimalFormat): Result[String, Float32] =
        Interop.Text.SubNumberFormat.toNumberFormat(df)
            |> Interop.Text.NumberFormat.parse(s)
            |> Result.map(Interop.Lang.Number.floatValue)


    pub def parseFloat64(s: String, df: DecimalFormat): Result[String, Float64] =
        Interop.Text.SubNumberFormat.toNumberFormat(df)
            |> Interop.Text.NumberFormat.parse(s)
            |> Result.map(Interop.Lang.Number.doubleValue)

    ///
    pub def toPattern(df: DecimalFormat): String =
        Interop.Text.DecimalFormat.toPattern(df)



    ///
    pub def toLocalizedPattern(df: DecimalFormat): String =
        Interop.Text.DecimalFormat.toLocalizedPattern(df)


    pub def getCurrency(df: DecimalFormat): Result[String, Currency] =
        Interop.Text.DecimalFormat.getCurrency(df)



}
