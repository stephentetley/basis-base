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


mod Basis.NIO.File {

    ///
    /// Represents a Path.
    ///
    pub type alias Path = Interop.NIO.File.Path


}

mod Basis.NIO.File.Path {

    use ToString.toString;

    use Basis.NIO.File.Path;



    ///
    /// Returns a new Path.
    ///
    pub def newPath(s: String): Result[String, Path] =
        Interop.NIO.File.Path.of(s, Nil)


    def filePath1(s: String): Path = match newPath(s) {
        case Ok(p1)  => p1
        case Err(_)  => empty()
    }

/*
    /// pub def filePathConcat(l: List[String]): Path =
    ///     region r {
    ///         import static java.nio.file.Path.of(String, Array[String, r]): ##java.nio.file.Path \ r as of1;
    ///         try {
    ///             match l {
    ///                 case x :: rs => Path(FlixSandbox.Deprecated.Marshal.runVaragsOfString(rs, of1(x), r)) as \ Pure
    ///                 case Nil     => empty()
    ///             }
    ///         } catch {
    ///             case _: ##java.lang.Exception => empty()
    ///         }
    ///     }


    pub def tryNew(s: String): Result[String, Path] =
        region r {
            Result.tryCatch(_ -> {
                import static java.nio.file.Path.of(String, Array[String, r]): ##java.nio.file.Path \ r as of1;
                Path(of1(s, [] @ r))
            })
        }
*/

    pub def empty(): Path =
        match newPath("") {
            case Ok(p1) => p1
            case Err(msg) => bug!(msg)
        }


    pub def normalize(path: Path): Path =
        Interop.NIO.File.Path.normalize(path)


    /// If `path` is a relative path `toAbsolutePath` resolves the path in a system specific manner.
    /// Should this be Impure?
    pub def toAbsolutePath(path: Path): Result[String, Path] =
        Interop.NIO.File.Path.toAbsolutePath(path)


    pub def isAbsolute(path: Path): Bool =
        Interop.NIO.File.Path.isAbsolute(path)

    pub def isRelative(path: Path): Bool = not isAbsolute(path)

    pub def getRoot(path: Path): Option[Path] =
        Interop.NIO.File.Path.getRoot(path)

    pub def getParent(path: Path): Option[Path] =
        Interop.NIO.File.Path.getParent(path)

    pub def getFileName(path: Path): Option[Path] =
        Interop.NIO.File.Path.getFileName(path)

    pub def splitFileName(path: Path): (Option[Path], Option[Path]) =
        (getParent(path), getFileName(path))

    pub def replaceFileName(path: Path, name: String): Path =
        let file = filePath1(name);
        match getParent(path) {
            case Some(dir) => append(dir, file)
            case None => file
        }

    /// e.g. getBaseName('/home.stephen.temp01.txt') = "temp01"
    pub def getBaseName(path: Path): Option[String] =
        forM (file <- getFileName(path);
                base <- Some(dropExtensions(file))
        ) yield toString(base)

    pub def putBaseName(path: Path, name: String): Path =
        match (getParent(path), getExtensions(path)) {
            case (Some(root), Some(exts)) => append(root, filePath1(name + "." + exts))
            case (None, Some(exts))       => filePath1(name + "." + exts)
            case (_, _)                   => path
        }

    pub def mapBaseName(f: String -> String, path: Path): Path =
        match getBaseName(path) {
            case Some(name1) => putBaseName(path, f(name1))
            case _ => path
        }

    pub def testBaseName(f: String -> Bool, path: Path): Bool =
        match getBaseName(path) {
            case Some(name1) => f(name1)
            case _ => false
        }


    pub def resolve(path: Path, other: Path): Path =
        Interop.NIO.File.Path.resolve(path, other)


    pub def append(path: Path, other: Path): Path =
        normalize(resolve(path, other))

    pub def concat(xs: List[Path]): Path = match xs {
        case Nil => empty()
        case root :: rs => normalize(List.foldLeft(resolve, root, rs))
    }

    pub def <<>>(path: Path, name1: String): Path = snoc(path, name1)

    pub def snoc(path: Path, name1: String): Path =
        match newPath(name1) {
            case Ok(path1) => append(path, path1)
            case Err(_) => path
        }

    pub def push(name1: String, path: Path): Path =
        match newPath(name1) {
            case Ok(path1) => append(path, path1)
            case Err(_)    => path
        }


    ///
    /// Returns `path1` with the path name contracted relative to `path2`.
    ///
    pub def makeRelative(path1: Path, path2: Path): Path =
        Interop.NIO.File.Path.relativize(path1, path2)

    ///
    /// Returns `true` if the Path `path1` starts with the string `path2`.
    ///
    pub def startsWith(prefix: {prefix = Path}, path2: Path): Bool =
        Interop.NIO.File.Path.startsWith(prefix = prefix.prefix, path2)


    pub def getNameCount(path: Path): Int32 =
        match getRoot(path) {
            case Some(_) => getNameCountHelper(path) + 1
            case None => getNameCountHelper(path)
        }

    /// Does not count root, if present.
    def getNameCountHelper(path: Path): Int32 =
        Interop.NIO.File.Path.getNameCount(path)

    pub def getNameAt(path: Path, ix: Int32): Option[Path] =
        if (ix < 0)
            None
        else
            match getRoot(path) {
                case Some(_) => if (ix == 0) getRoot(path) else getNameAtHelper(path, ix-1)
                case None => getNameAtHelper(path, ix)
            }
    ///
    /// Helper function for `getNameAt`.
    ///
    /// This is a wrapper around the Java function `getName` which does not
    /// look at root, if present.
    ///
    def getNameAtHelper(path: Path, ix: Int32): Option[Path] =
        Interop.NIO.File.Path.getNameAt(ix, path) |> Result.toOption

    pub def hasExtension(path: Path): Bool =
        match getFileName(path) |> Option.map(toString) {
            case None => false
            case Some(str) => String.startsWith({prefix = "."}, str)
        }


    pub def getExtension(path: Path): Option[String] =
        forM (s <- getFileName(path) |> Option.map(toString);
                ix <- String.indexOfRight({substr = "."}, s)
        ) yield String.sliceRight(start = ix+1, s)

    ///
    /// Replaces the extension.
    /// If the Path has multiple extenstion only the rightmost extension
    /// is replaced.
    ///
    pub def putExtension(path: Path, ext: String): Path =
        match getExtension(path) {
            case Some(ext0) => {
                let str = toString(path);
                let lhs = String.dropRight(String.length(ext0), str);
                filePath1(lhs + ext)
            }
            case None => path
        }

    ///
    /// Drop only the rightmost extension if the Path has mutliple
    /// extensions, i.e. "archive.tar.gz" becomes "archive.tar".
    ///
    pub def dropExtension(path: Path): Path = match getExtension(path) {
        case Some(ext) => {
            let str = toString(path);
            let lhs = String.dropRight(String.length(ext) + 1, str);
            filePath1(lhs)
        }
        case None => path
    }

    pub def splitExtension(path: Path): (Path, Option[String]) =
        (dropExtension(path), getExtension(path))

    pub def mapExtension(f: String -> String, path: Path): Path =
        let (path1, ext) = splitExtension(path);
        match ext {
            case Some(s1) => addExtension(path1, f(s1))
            case None => path
        }

    /// false if no extension
    pub def testExtension(f: String -> Bool, path: Path): Bool =
        match getExtension(path) {
            case Some(s1) => f(s1)
            case None => false
        }

    pub def isExtension(path: Path, ext: String): Bool =
        testExtension(x -> x == ext, path)

    pub def isExtensionOneOf(path: Path, xs: List[String]): Bool =
        testExtension(x -> List.memberOf(x, xs), path)

    /// Suffixes the extension `ext` even if the path already has an extension.
    /// e.g. addExtension("archive.tar", "gz") == "archive.tar.gz"
    pub def addExtension(path: Path, ext: String): Path =
        if (String.isEmpty(ext))
            path
        else {
            let str = toString(path);
            filePath1(str + "." + ext)
        }

    ///
    /// Return all extensions if the Path has multiple extensions,
    /// i.e. "archive.tar.gz" becomes "tar.gz".
    ///
    pub def getExtensions(path: Path): Option[String] =
        use Option.flatMap;
        forM (s <- getFileName(path) |> Option.map(toString);
                ix <- String.indexOfLeft({substr = "."}, s)
        ) yield String.sliceRight(start = ix + 1, s)

    ///
    /// Drop all extensions if the Path has mutliple extensions,
    /// i.e. "archive.tar.gz" becomes "archive".
    ///
    pub def dropExtensions(path: Path): Path = match getExtensions(path) {
        case Some(ext) => {
            let str = toString(path);
            let lhs = String.dropRight(String.length(ext) + 1, str);
            filePath1(lhs)
        }
        case None => path
    }

    pub def putExtensions(path: Path, ext: String): Path =
        match getExtensions(path) {
            case Some(ext0) => {
                let str = toString(path);
                let lhs = String.dropRight(String.length(ext0), str);
                filePath1(lhs + ext)
            }
            case None => path
        }

    pub def splitExtensions(path: Path): (Path, Option[String]) =
        (dropExtensions(path), getExtensions(path))

    ///
    /// Drop the extension `ext` from the Path and the dot preceeding it.
    /// If the extension of the Path does not match ext or the Path
    /// does not have an extension return None.
    ///
    pub def stripExtension(path: Path, ext: String): Option[Path] =
        forM (ext1 <- getExtension(path);
                ans <- if (ext1 == ext) Some(dropExtension(path)) else None
        ) yield ans

    /// Multiple extension version of `stripExtension`.
    pub def stripExtensions(path: Path, exts: String): Option[Path] =
        forM (exts1 <- getExtensions(path);
                ans <- if (exts1 == exts) Some(dropExtensions(path)) else None
        ) yield ans

    pub def split(path: Path): List[Path] =
        let n = getNameCount(path);
        splitHelper(path, n, 0, xs -> xs)

    def splitHelper(path: Path, count: Int32, i: Int32, k: List[Path] -> List[Path]): List[Path] =
        if (i >= count)
            k(Nil)
        else
            // Note - `None` case should be impossible.
            match getNameAt(path, i) {
                case Some(x) => splitHelper(path, count, i+1, xs -> k(x :: xs))
                case None => k(Nil)
            }
/*
    def pathMatcherMatches(path: Path, syntaxAndPatt: String): Result[String, Bool] \ IO =
        import static java.nio.file.FileSystems.getDefault(): ##java.nio.file.FileSystem \ IO;
        import java.nio.file.FileSystem.getPathMatcher(String): ##java.nio.file.PathMatcher \ IO;
        import java.nio.file.PathMatcher.matches(##java.nio.file.Path): Bool \ IO;
        try {
            let Path(path1) = path;
            let fs = getDefault();
            let m1 = getPathMatcher(fs, syntaxAndPatt);
            Ok(matches(m1, path1))
        } catch {
            case _: ##java.lang.Exception => Err("pathMatcherMatches")
        }

    pub def isGlobMatch(glob: String, path: Path): Result[String, Bool] =
        pathMatcherMatches(path, "glob:" + glob)

    pub def isRegexMatch(patt: String, path: Path): Result[String, Bool] =
        pathMatcherMatches(path, "regex:" + patt)

*/

    pub def toFile(r: Region[r], path: Path): Result[String, Interop.IO.File[r]] \ r =
        Interop.NIO.File.Path.toFile(r, path)

    pub def fromFile(file: Interop.IO.File[r]): Result[String, Path] \ r =
        Interop.IO.File.toPath(file)

}
