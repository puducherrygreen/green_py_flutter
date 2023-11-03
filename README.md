# green_puducherry

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



POST
curl --location 'https://us-central1-green-puducherry.cloudfunctions.net/app/v1/user/create/user
--header 'Content-Type: application/json' \
--data-raw '{
"userName":"Gomathi",
"email":"gomathi@gmail.com",
"mobileNumber":"94357354453",
"regionId":"64d1ca42-f1d8-4968-903a-ebdbdf4ea06a",
"communeId":"c471982f-a7e1-4d4f-97c5-c26731aedfc5",
"address":"sfsd gfd",
"pincode":"7876876"

}'

GET
https://us-central1-green-puducherry.cloudfunctions.net/app/v1/user/get/region/list
get region data

GET
https://us-central1-green-puducherry.cloudfunctions.net/app/v1/user/get/commune/byRegionId/64d1ca42-f1d8-4968-903a-ebdbdf4ea06a
get commune by passing region id