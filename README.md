# Hechio Autochek - Car Seller App

This Autochek take away test for Senior iOS Engineer position.
<img src="https://user-images.githubusercontent.com/47601553/174427604-cdea07cd-c145-41a9-a741-fa757726b23b.png" width="500" height="200" style="max-width:100%;">

## Table of Contents

- [Prerequisite](#prerequisite)
- [The App](#theapp)
- [Languages](#language)
- [ScreenShots](#screenshots)
- [Video Recording of the App](#videorecordingoftheapp])

## Prerequisite
This app have been built using Xcode 13. To Run the app, go to the project directory, under `Signing $ Capabilities`, add your developer team account.

## The App
The app gets list of all popular makes from [Popular Brand API](https://api.staging.myautochek.com/v1/inventory/make?popular=true), list all the cars from a paginated response from [Cars API](https://api.staging.myautochek.com/v1/inventory/car/search) and shows [Details](https://api.staging.myautochek.com/v1/inventory/car/{carId}) including video from [Media API](https://api.staging.myautochek.com/v1/inventory/car_media?carId={carId})
The app have two view controllers: the `HomeViewController` that list popular brands and all cars, and `CarDetailsController` that show car details and media.

## Languages
The project has been written in <b>Swift</b> language and design using <b>UIKit</b>. For network requests, it uses URLSession with <b>RxSwift</b>.

## ScreenShots

<img src="https://user-images.githubusercontent.com/47601553/174428544-dee14164-a59b-4e55-b2c7-3bd60f070b5d.png" width="200" style="max-width:100%;"> <img src="https://user-images.githubusercontent.com/47601553/174427181-e56cc240-3c18-4bc3-b382-511492d1dd27.png" width="200" style="max-width:100%;"> <img src="https://user-images.githubusercontent.com/47601553/174427193-e64e8401-73c7-434a-b870-1d90b5767961.png" width="200" style="max-width:100%;"> <img src="https://user-images.githubusercontent.com/47601553/174427200-09ac94ff-dc34-4cec-95a6-855b14f944f2.png" width="200" style="max-width:100%;"> 


## Video Recording of the App

https://user-images.githubusercontent.com/47601553/174427455-5f36887b-afcb-4947-bf44-d7913a94cde9.mp4

