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

namespace TestCharset { 


    @test
    def aliases01(): Unit & Impure = 
        Basis/NIO/Charset/Charset.utf_8() |> Basis/NIO/Charset/Charset.aliases |> Set.forEach(println)

    @test
    def availableCharsets01(): Unit & Impure = 
        Basis/NIO/Charset/Charset.availableCharsets() |> Map.toList |> List.forEach(println)


}
