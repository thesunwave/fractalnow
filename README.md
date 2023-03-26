# FractalNow Server
This is a simple Rack application that renders fractals using the fractalnow command line tool.

## Requirements
To use this application, you need to have fractalnow installed on your system. You can download it from the official [website](https://fractalnow.sourceforge.io/).

Or use Docker. You can find convenient way to run the app below.

## Usage
### Using Docker Compose
* Make sure you have Docker and Docker Compose installed.
* Clone the repository
* Navigate to the project directory: cd fractal-now
* Start the application: docker-compose up
* Send a POST request with a fractal configuration file to http://localhost:8080/fractal
* The response will be a PNG image of the rendered fractal.

### Without Docker
* Make sure you have Ruby and the fractalnow executable installed.
* Clone the repository
* Navigate to the project directory: cd fractal-now
* Install the required gems: `bundle install`
* Start the application: `bundle exec puma`
* Send a POST request with a fractal configuration file to http://localhost:9292/fractal
* The response will be a PNG image of the rendered fractal.

## API
The application provides a single endpoint that accepts POST requests:

```bash
POST /fractal
```
The request body should be a JSON object with the following properties:

| Property | Type | Required | Description |
| ---- | ---- | ---- | ---- |
| config | String | Yes | The configuration for the fractal, in FractalNow format. |

If the request is successful, the server responds with a binary image in PPM format.
