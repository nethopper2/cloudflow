package main

import (
	"log"
	"net/http"
	"os"
	"os/signal"
	"strings"
	"syscall"
	"time"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var (
	pingsOk = promauto.NewCounter(prometheus.CounterOpts{
		Name: "ping_service_success_cnt",
		Help: "The total number of successful service pings",
	})
)

var (
	pingErrors = promauto.NewCounter(prometheus.CounterOpts{
		Name: "ping_service_error_cnt",
		Help: "The total number of unsuccessful service pings",
	})
)

func main() {
	urls := strings.Split(os.Getenv("PING_URLS"), ",")

	for _, url := range urls {
		go pingURL(url) // 'go' makes call run in bg (go does concurrency)
	}

	// setup metrics
	go func() {
		http.Handle("/metrics", promhttp.Handler())
		http.ListenAndServe(":2112", nil)
	}()

	// run forever (until ^C (docker) or deleted (k8s))
	stop := make(chan os.Signal, 1)
	signal.Notify(stop, syscall.SIGINT, syscall.SIGTERM)
	<-stop

	log.Println("Terminating ...")
}

func pingURL(url string) {

	// strip whitespace
	url = strings.TrimSpace(url)

	// ping and wait 5 seconds in an infinite loop
	for {

		log.Println("Pinging " + url)
		_, err := http.Get(url)

		if err == nil {
			pingsOk.Inc()
		} else {
			pingErrors.Inc()
			log.Println("There was an error pinging " + url)
		}

		time.Sleep(5 * time.Second)
	}
}
