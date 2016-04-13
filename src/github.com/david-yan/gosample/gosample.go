package main

import (
    "fmt"
    "net/http"
    "io/ioutil"
    "os"
    )

func main() {
    response, err := http.Get("https://github.com/aporeto-inc/internship2016/blob/master/samples/problem2/uniquified_file.txt")
    if err != nil {
        fmt.Printf("%s", err)
        os.Exit(1)
    } else {
        defer response.Body.Close()
        contents, err := ioutil.ReadAll(response.Body)
        if err != nil {
            fmt.Printf("%s", err)
            os.Exit(1)
        }
        fmt.Printf("%s\n", string(contents))
    }
}