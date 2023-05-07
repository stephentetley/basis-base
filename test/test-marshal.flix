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

mod TestMarshal { 

/*

@test
def testMarshal01(): Unit \ IO = 
    let upcast = x1 -> x1 as ##java.lang.Object;
    let s1 = Marshal.marshalSet(upcast, Set#{"hello", "world"});
    println("Marshal: ${setSize(s1)}");
    ()

@test
def testMarshal02(): Unit \ IO = 
    let upcast = x1 -> x1 as ##java.lang.Object;
    let downcast = x1 -> x1 as ##java.lang.String;
    let s1 = Marshal.marshalSet(upcast, Set#{"hello", "world", "!"});
    let s2 = Marshal.unmarshalSet(downcast, s1);
    println("Unmarshal: ${s2}");
    ()


@test
def testMarshal03(): Unit \ IO = 
    let upcast = x1 -> x1 as ##java.lang.Object;
    let downcast = x1 -> x1 as String;
    let l1 = Marshal.marshalList(upcast, "hello" :: "world" :: "!" :: Nil);
    let l2 = Marshal.unmarshalList(downcast, l1);
    println("Unmarshal: ${l2}");
    ()


@test
def testMarshal04(): Unit \ IO = 
    let upcastK = x1 -> x1 as ##java.lang.Object;
    let upcastV = x1 -> x1 as ##java.lang.Object;
    let downcastK = x1 -> x1 as String;
    let downcastV = x1 -> x1 as String;
    let m1 = Marshal.marshalMap(upcastK, upcastV, Map#{"A" => "hello", "B" => "world"});
    let m2 = Marshal.unmarshalMap(downcastK, downcastV, m1);
    println("Unmarshal: ${m2}");
    ()

@test
def testMarshal05(): Unit \ IO = 
    let upcastK = x1 -> valueOf(x1) as ##java.lang.Object;
    let upcastV = x1 -> x1 as ##java.lang.Object;
    let downcastK = x1 -> intValue(x1 as ##java.lang.Integer);
    let downcastV = x1 -> x1 as String;
    let m1 = Marshal.marshalMap(upcastK, upcastV, Map#{1 => "hello", 5 => "world"});
    let m2 = Marshal.unmarshalMap(downcastK, downcastV, m1);
    println("Unmarshal: ${m2}");
    ()


def setSize(s: ##java.util.Set): Int32 \ IO =
    import java.util.Set.size(): Int32 \ IO;
    size(s)

def valueOf(i: Int32): ##java.lang.Integer = 
    import static java.lang.Integer.valueOf(Int32): ##java.lang.Integer \ {};
    valueOf(i)

def intValue(i: ##java.lang.Integer): Int32 = 
    import java.lang.Integer.intValue(): Int32 \ {};
    intValue(i)

*/

}