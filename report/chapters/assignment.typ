= Exercise 1
To make the first exercise I decided to classify 2 different items: a Rubik's cube and the Airpods' case. I took 40 pictures for each item, and also I took 40 pictures of the background.

After training the model with an 80/20 split, I got the following results in the model testing section of Edge Impulse:
#image("/report/images/image.png")
Note that the accuracy is very high, but the dataset is very small and the task is very easy.
#pagebreak()
After the deployment here is the QR code to test the model on your phone:
#show image: it => {
  align(center, it)
}
#figure(
  image("/report/images/image-2.png"),
  caption: "QR code of the model"
)
#pagebreak()
= Exercise 2
For the second exercise, I built a dashboard to monitor some metrics of the CPU and memory usage of my device. In particular I used the plugins of Telegraf to collect the CPU and memory usage and I sent the data to InfluxDB. Then I created a dashboard in Grafana to visualize the data. All the components are running in Docker containers.
#linebreak()

#figure(
  image("/report/images/dashboard.png", width: 120%),
  caption: "Grafana dashboard to monitor CPU and memory usage"
)
#linebreak()
The dashboard is very simple:
#list(
  indent: 1.5em,
  [on the upper left corner there is a graph that shows the CPU user usage over time;],
  [on the upper right corner there is a graph that shows the total CPU usage over time;],
  [on the lower left corner there is a graph that shows the amount of free memory over time;],
  [on the lower right corner there is a graph that shows the amount of used memory in percentage.]
)
#pagebreak()

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
// set block of codes with codly
#show: codly-init.with()
#codly(languages: codly-languages)
#codly(smart-indent: true)
= Exercise 3
In the third exercise I wrote a docker-compose file to run two MQTT brokers simultaneously in two different containers. 

#show figure: set block(breakable: true)
#figure(
  caption: "docker-compose file",
```yml
services:
    broker_a:
        image: eclipse-mosquitto:latest
        container_name: broker_a
        ports:
          - "1883:1883"
        volumes:
          - ./mosquitto:/mosquitto
        networks:
          - pubsub-net

    broker_b:
      image: eclipse-mosquitto:latest
      container_name: broker_b
      ports:
        - "1884:1883"
      volumes:
        - ./mosquitto:/mosquitto
      networks:
        - pubsub-net

networks:
    pubsub-net:
        driver: bridge

```
)
#linebreak()

After running the docker-compose file the two brokers were running simultaneously, and I was able to use the efrecon/mqtt-client image to publish and subscribe to each broker separately by specifying the appropriate port (1883 for broker_a and 1884 for broker_b).


= Exercise 4 and 5

For the last two exercises, I wrote a Telegram bot that can be used to get the current temperature in Padua. The bot uses the Open-Meteo API to get the current weather data and it sends the temperature to the user when they send the "/getdata" command. Furthermore, the bot can be used to get some other basic statistics about the weather in Padua, such as the average, the minimum and maximum temperature, and a history of the last 10 measurements.

In the implementation of the bot, I used a REST-based API to get the current weather data from the Open-Meteo server, and I used a local SQLite database to store the temperature measurements. 

The difference between a REST-based API (pull model) and a MQTT-based API (push model) is that the REST-based API uses a synchronous Request/Response architecture over HTTP, while the MQTT-based API uses an asynchronous Publish/Subscribe architecture.

#linebreak()
The code of the bot is available at this GitHub repository:
https://github.com/yourusername/telegram-bot

#linebreak()
In the following @figure-bot you can see the Telegram bot in action, showing the current temperature in Padua and some statistics about it.


#figure(
  image("/report/images/bot.png", width: 120%),
  caption: "Telegram bot to get the current temperature in Padua and some statistics about it."
)<figure-bot>