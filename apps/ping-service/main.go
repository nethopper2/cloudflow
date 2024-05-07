package main

import (
	"log"
	"net/http"
	"os"
	"os/signal"
	"strings"
	"syscall"
	"time"
)

func main() {
	urls := strings.Split(os.Getenv("PING_URLS"), ",")

	for _, url := range urls {
		go pingURL(url) // 'go' makes call run in bg (go does concurrency)
	}

	// run forver (until ^C)
	stop := make(chan os.Signal, 1)
	signal.Notify(stop, syscall.SIGINT, syscall.SIGTERM)
	<-stop // wait for ^C

	log.Println("Terminating ...")
}

func pingURL(url string) {

	// strip whitespace
	url = strings.TrimSpace(url)

	// ping and wait 5 seconds in an infinite loop
	for {

		log.Println("Pinging " + url)
		_, err := http.Get(url)

		if err != nil {
			log.Println("There was an error pinging " + url)
		}

		time.Sleep(5 * time.Second)
	}
}
