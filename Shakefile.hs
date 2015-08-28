import Data.List
import System.Process
import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util

main :: IO ()
main = shakeArgs shakeOptions $ do
    want ["poster.pdf"]

    "poster.pdf" %> \out -> do
        files <- getDirectoryFiles "." ["//*.tex","//*.m"]
        need files
        command_  [] "pdflatex" ["-halt-on-error", dropExtension out ]

    phony "clean" $ do 
    liftIO $ removeFiles "." $ map ("poster."++) (words "log toc aux blg bbl snm out nav") 

