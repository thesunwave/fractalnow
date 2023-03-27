# FractalNow Server
This is a simple Rack application that renders fractals using the fractalnow command line tool.

## Requirements
To use this application, you need to have fractalnow installed on your system. You can download it from the official [website](https://fractalnow.sourceforge.io/).

Or use Docker. You can find convenient way to run the app below.

## Usage
### Using Docker Compose
* Make sure you have Docker and Docker Compose installed.
* Clone the repository
* Navigate to the project directory: `cd fractal-now`
* Start the application: `docker-compose up`
* Send a POST request with a fractal configuration file to http://localhost:8080/fractal
* The response will be an image of the rendered fractal.

### Without Docker
* Make sure you have Ruby and the fractalnow executable installed.
* Clone the repository
* Navigate to the project directory: `cd fractal-now`
* Install the required gems: `bundle install`
* Start the application: `bundle exec puma`
* Send a POST request with a fractal configuration file to http://localhost:8080/fractal
* The response will be an image of the rendered fractal.

## API
The application provides a single endpoint that accepts POST requests:

```bash
POST /fractal
```
The request body should be a plain text, for example:

```
c075
mandelbrot
-6.999999999999999555910790149937383830547E-01 0E+00
3.857142857142857142857142857142857142859E+00 3E+00
1000 1000
1
0x0
iterationcount
smooth
log
0.45 0.2
0 0x39a0 0.25 0xffffff 0.5 0xfffe43 0.75 0xbf0800 1 0x39a0
```

If the request is successful, the server responds with a binary image in PPM format.
