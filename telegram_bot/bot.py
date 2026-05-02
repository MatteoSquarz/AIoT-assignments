import json
from telegram.ext import Application, CommandHandler, MessageHandler, filters
import requests
import os
from dotenv import load_dotenv
import db_operations
from datetime import datetime, timezone

load_dotenv()

BOT_TOKEN = os.getenv('TELEGRAM_BOT_TOKEN')
API_URL = "https://api.open-meteo.com/v1/forecast?latitude=45.4064&longitude=11.8768&current_weather=true"


async def start(update, context):
    options_text = ("Hi! I'm a Bot 🤖. \n\nAvailable commands: \n" +
    "/getdata - Get current temperature 🌡️\n" +
    "/history - Last 10 measurements 📋\n" +
    "/average - Average temperature 📊\n" +
    "/max - Max temperature 📈\n" +
    "/min - Min temperature 📉")
    await context.bot.send_message(chat_id=update.effective_chat.id, text=options_text)


async def getdata(update, context):
    response = requests.get(API_URL)
    data = response.json()
    temp = data['current_weather']['temperature']
    db_operations.save_data_to_db(temp)
    await context.bot.send_message(chat_id=update.effective_chat.id,
                                   text=f"🌡️ Current temperature in Padua is: {temp}°C")
    
async def history(update, context):
    measurements = db_operations.get_last_n_measurements(10)
    if measurements:
        history_text = "📋 Last 10 temperature measurements:\n"
        if len(measurements) < 10:
            history_text += f"(only {len(measurements)} measurements available)\n"
        for i, (timestamp, temp) in enumerate(measurements):
            timestamp = datetime.fromisoformat(timestamp).strftime('%Y-%m-%d %H:%M:%S')
            history_text += f"{i+1}. [{timestamp}]: {temp}°C\n"
    else:
        history_text = "No temperature data available."
    await context.bot.send_message(chat_id=update.effective_chat.id, text=history_text)

async def average_temperature(update, context):
    data = db_operations.get_avg_temperature()
    avg_temp = data[0]
    count = data[1]
    if avg_temp is not None:
        await context.bot.send_message(chat_id=update.effective_chat.id,
                                       text=f"📊 Average temperature: {avg_temp:.1f}°C (over {count} measurements)")
    else:
        await context.bot.send_message(chat_id=update.effective_chat.id,
                                       text="No temperature data available to calculate average temperature.")
        

async def max_temperature(update, context):
    data = db_operations.get_max_temperature()
    max_temp = data[0]
    count = data[1]
    if max_temp is not None:
        await context.bot.send_message(chat_id=update.effective_chat.id,
                                       text=f"📈 Max temperature: {max_temp:.1f}°C (over {count} measurements)")
    else:
        await context.bot.send_message(chat_id=update.effective_chat.id,
                                       text="No temperature data available to calculate max temperature.")

async def min_temperature(update, context):
    data = db_operations.get_min_temperature()
    min_temp = data[0]
    count = data[1]
    if min_temp is not None:
        await context.bot.send_message(chat_id=update.effective_chat.id,
                                       text=f"📉 Min temperature: {min_temp:.1f}°C (over {count} measurements)")
    else:
        await context.bot.send_message(chat_id=update.effective_chat.id,
                                       text="No temperature data available to calculate min temperature.")

async def unknown(update, context):
    options_text = (
        "Sorry I don't understand this command. 😕\n\n"
    )
    await context.bot.send_message(chat_id=update.effective_chat.id, text=options_text)



if __name__ == '__main__':
    db_operations.init_db()  # Initialize the database
    
    application = Application.builder().token(BOT_TOKEN).build()

    ## commands handlers
    start_handler = CommandHandler('start', start)
    application.add_handler(start_handler)

    getdata_handler = CommandHandler('getdata', getdata)
    application.add_handler(getdata_handler)

    history_handler = CommandHandler('history', history)
    application.add_handler(history_handler)

    average_handler = CommandHandler('average', average_temperature)
    application.add_handler(average_handler)

    max_handler = CommandHandler('max', max_temperature)
    application.add_handler(max_handler)

    min_handler = CommandHandler('min', min_temperature)
    application.add_handler(min_handler)

    unknown_handler = MessageHandler(filters.TEXT | (~filters.COMMAND), unknown)
    application.add_handler(unknown_handler)

    # starts bot
    application.run_polling()
