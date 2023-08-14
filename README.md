- [Flutter Flatpak Example](#flutter-flatpak-example)
  - [Requirements](#requirements)
    - [VSCode dev container](#vscode-dev-container)
    - [GitHub actions](#github-actions)
    - [Manual Requirements](#manual-requirements)
  - [Instructions](#instructions)


# Flutter Flatpak Example


An example of how to package a Flutter application as a Flatpak for distribution
on Linux, using the default counter example app.

[Flatpak documentation](https://docs.flatpak.org/en/latest/index.html)



## Requirements

> Note: Building a flatpak should be done in a predictable environment or it may
> fail.

[Set up Flathub](https://flatpak.org/setup/), and choose one:

### VSCode dev container

Use the VSCode dev container provided in this repo that will run everything
through Docker

1. Install the [Dev
   Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
   extension
   
2. Open this directory in VSCode.

3. Accept the prompt to re-open in the dev container, or from the Command
   Palette search for `Reopen in Container`


### GitHub actions

> There is a [GitHub
> action](https://github.com/bilelmoussaoui/flatpak-github-actions) for this
> purpose, which is demonstrated in this repo. This action's page also lists the
> docker containers it uses.
> 
> If you fork this example repo you can run the [example workflow](https://github.com/Merrit/flutter_flatpak_example/blob/main/.github/workflows/flatpak.yml), and
> install the `.flatpak` file it generates with `flatpak install <path-to-.flatpak>`.


### Manual Requirements

Install flatpak and flatpak-builder

On ubuntu:

```bash
sudo apt install flatpak flatpak-builder
```

Add the FlatHub repo:

```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

Install flatpak build dependencies:

```bash
flatpak install -y org.freedesktop.Sdk/x86_64/22.08
flatpak install -y org.freedesktop.Platform/x86_64/22.08
flatpak install -y flathub org.freedesktop.appstream-glib
```


## Instructions

We have two directories that each represent what would be separate git
repositories for a real project:

[counter_app](counter_app/) is the Flutter app, view the README there for info on
configuration and building.

[flathub_repo](flathub_repo/) is separate from the Flutter app and is where the Flatpak is
assembled, view the README there for info on configuration, building, and
publishing of the flatpak after building the `counter_app`.

appflowy-flutter-example://login-callback#access_token=eyJhbGciOiJIUzI1NiIsImtpZCI6Ik5wS2tVZVBKVDRBZnI0VG8iLCJ0eXAiOiJKV1QifQ.eyJhdWQiOiJhdXRoZW50aWNhdGVkIiwiZXhwIjoxNjkyMDEzMDEwLCJpYXQiOjE2OTIwMDk0MTAsImlzcyI6Imh0dHBzOi8vcWpwYXRlbml2a2x2YWhwd3Bhcmsuc3VwYWJhc2UuY28vYXV0aC92MSIsInN1YiI6IjA4NjNjODU1LThmNmQtNGNiYy04YTA0LThiNzJjOGVkODVmOSIsImVtYWlsIjoibHVjYXMueHVAYXBwZmxvd3kuaW8iLCJwaG9uZSI6IiIsImFwcF9tZXRhZGF0YSI6eyJwcm92aWRlciI6Imdvb2dsZSIsInByb3ZpZGVycyI6WyJnb29nbGUiXX0sInVzZXJfbWV0YWRhdGEiOnsiYXZhdGFyX3VybCI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FBY0hUdGZFZVVvZ1dsbUpaM2hyWVNRdXItSHIxMEhNeXV4cm5oY3hHOGJ6SzM0QT1zOTYtYyIsImN1c3RvbV9jbGFpbXMiOnsiaGQiOiJhcHBmbG93eS5pbyJ9LCJlbWFpbCI6Imx1Y2FzLnh1QGFwcGZsb3d5LmlvIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImZ1bGxfbmFtZSI6Ikx1Y2FzIFh1IiwiaXNzIjoiaHR0cHM6Ly9hY2NvdW50cy5nb29nbGUuY29tIiwibmFtZSI6Ikx1Y2FzIFh1IiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FBY0hUdGZFZVVvZ1dsbUpaM2hyWVNRdXItSHIxMEhNeXV4cm5oY3hHOGJ6SzM0QT1zOTYtYyIsInByb3ZpZGVyX2lkIjoiMTExODA4MTI5ODM1MzkzMTYwNzQ1Iiwic3ViIjoiMTExODA4MTI5ODM1MzkzMTYwNzQ1In0sInJvbGUiOiJhdXRoZW50aWNhdGVkIiwiYWFsIjoiYWFsMSIsImFtciI6W3sibWV0aG9kIjoib2F1dGgiLCJ0aW1lc3RhbXAiOjE2OTIwMDk0MTB9XSwic2Vzc2lvbl9pZCI6ImRiNzhlM2YwLThhYmItNDA0Zi1hNWJhLWUwMDljMjEzZTE0MSJ9.UQ4VR0Vct9TKvHCM2p8BAX6rd9XeEqOt_0BlVPy_4PA&expires_in=3600&provider_refresh_token=1%2F%2F0dCXynOCs-TC0CgYIARAAGA0SNwF-L9Ir7xQFgR7hlNYM9uQajdT9h5RaR-NHTpVM0AMQxuydb3qrVboMSmWN9fv5SQ8Lqit--eg&provider_token=ya29.a0AfB_byCF4MdlcTqhQAqxeYWPuyWY1dX_E-cYHok9xnFk1RADgRq_adhoKRuR4WIpLtUDfxR1ZAVPe98E8OILX8GKPfI5V-TlF0GUqls3IGNLrjS3W9GxJYA5k3i_5stvt_LhsSisLOJnaRMQy89MD1zb9_HsaCgYKAdsSARESFQHsvYlsLg9aKre4JC2FVe8eFTAycg0163&refresh_token=Y_BBLFwgyVC8B8DBvj7leQ&token_type=bearer
