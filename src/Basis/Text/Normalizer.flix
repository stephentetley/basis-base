/*
 * Copyright 2020 Stephen Tetley
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


mod Basis.Text.Normalizer {

    use Interop.Text.NormalizerForm.{NormalizerForm}
    use Basis.Text.Normalizer.NormalizerForm
    use Basis.Text.Normalizer.NormalizerForm.{Nfc, Nfd, Nfkc, Nfkd}

    ///
    pub enum NormalizerForm with Eq, Order, ToString, Hash {
        case Nfc
        case Nfd
        case Nfkc
        case Nfkd
    }

    pub def marshal(x: NormalizerForm): Interop.Text.NormalizerForm =
        match x {
            case Nfc    => Interop.Text.NormalizerForm.nfc()
            case Nfd    => Interop.Text.NormalizerForm.nfd()
            case Nfkc   => Interop.Text.NormalizerForm.nfkc()
            case Nfkd   => Interop.Text.NormalizerForm.nfkd()
        }


    pub def normalize(nform: NormalizerForm, src: String): Result[String, String] =
        Interop.Text.Normalizer.normalize(marshal(nform), src)

    pub def isNormalized(nform: NormalizerForm, src: String): Result[String, Bool] =
        Interop.Text.Normalizer.isNormalized(marshal(nform), src)


}
