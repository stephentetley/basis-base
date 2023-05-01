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


mod Basis.Math.RoundingMode {

    use Basis.Math.RoundingMode.RoundingMode.{
        Ceiling, Down, Floor, HalfDown, 
        HalfEven, HalfUp, Unnecessary, Up
    }

    pub enum RoundingMode with Eq, Order, ToString, Hash {
        case Ceiling
        case Down
        case Floor
        case HalfDown
        case HalfEven
        case HalfUp
        case Unnecessary
        case Up
    }


    pub def marshallRoundingMode(x: RoundingMode): Interop.Math.RoundingMode =
        match x {
            case Ceiling        => Interop.Math.RoundingMode.ceiling()
            case Down           => Interop.Math.RoundingMode.down()
            case Floor          => Interop.Math.RoundingMode.floor()
            case HalfDown       => Interop.Math.RoundingMode.half_down()
            case HalfEven       => Interop.Math.RoundingMode.half_even()
            case HalfUp         => Interop.Math.RoundingMode.half_up()
            case Unnecessary    => Interop.Math.RoundingMode.unnecessary()
            case Up             => Interop.Math.RoundingMode.up()
        }


    pub def unmarshallRoundingMode(i: Interop.Math.RoundingMode): RoundingMode =
        match i {
            case n if primEquals(n, Interop.Math.RoundingMode.ceiling())        => Ceiling
            case n if primEquals(n, Interop.Math.RoundingMode.down())           => Down
            case n if primEquals(n, Interop.Math.RoundingMode.floor())          => Floor
            case n if primEquals(n, Interop.Math.RoundingMode.half_down())      => HalfDown
            case n if primEquals(n, Interop.Math.RoundingMode.half_even())      => HalfEven
            case n if primEquals(n, Interop.Math.RoundingMode.half_up())        => HalfUp
            case n if primEquals(n, Interop.Math.RoundingMode.unnecessary())    => Unnecessary
            case n if primEquals(n, Interop.Math.RoundingMode.up())             => Up
            case _                                                              => bug!("unmarshallRoundingMode")
        }

    def primEquals(x: Interop.Math.RoundingMode, y: Interop.Math.RoundingMode): Bool = 
        Interop.Lang.Enum.equals(Interop.Lang.SubEnum.toEnum(x), Interop.Lang.SubEnum.toEnum(y))

}
