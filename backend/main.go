package main

import (
    "encoding/json"
    "github.com/gorilla/mux"
    "log"
	"net/http"
	"math/rand"
	"time"
)

/// The character set we use to create the random seed.
///
var charactersForSeed = []rune("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")

type Membership struct {
	Seed		string	`json:"seed,omitempty"`
	Expires	string	`json:"expires_at,omitempty"`
}

/// Random seed generator
///
func GenerateRandomSeed(n int) string {
	charList := make([]rune, n)
	for i := range charList {
        charList[i] = charactersForSeed[rand.Intn(len(charactersForSeed))]
    }
    return string(charList)
}

/// ISO 8601 timestamp generator.
/// The timestamps are generated as: current time + 2 hours.
///
func GenerateExpirationTimeInISO8601() string {
	return time.Now().UTC().Add(time.Hour * time.Duration(2)).Format(time.RFC3339)
}

/// Endpoint to handle the membership token issuing
/// based on the random seed and expiry time.
///
func GetMembership(w http.ResponseWriter, r *http.Request) {
	randomSeed := GenerateRandomSeed(32)
	timeStampExpiringInTwoHours := GenerateExpirationTimeInISO8601()
	membership := Membership{Seed: randomSeed, Expires: timeStampExpiringInTwoHours}
    json.NewEncoder(w).Encode(membership)
}

/// Main function intializes golang random algorithm seed
/// and exposes HTTP service to the localhost port 3000.
///
func main() {
	rand.Seed(time.Now().UnixNano())
    router := mux.NewRouter()
    router.HandleFunc("/seed", GetMembership).Methods("GET")
    log.Fatal(http.ListenAndServe(":3000", router))
}