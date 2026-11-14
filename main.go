package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("成功！"))
	})

	fmt.Println("Server listening on :8080")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		fmt.Println("Server error:", err)
	}
}
