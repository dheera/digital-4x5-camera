import json
import os

with open(os.path.join(os.path.dirname(__file__), "config.json"), "r") as f:
    config = json.loads(f.read())
    for axis in config["axes"]:
        axis["distance_per_step"] = axis["length"] / axis["steps"]

    config["sensor"]["sensor_size"] = [
        config["sensor"]["pixel_size"][0] * config["sensor"]["num_pixels"][0],
        config["sensor"]["pixel_size"][1] * config["sensor"]["num_pixels"][1],
    ]
