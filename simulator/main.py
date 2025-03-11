import mujoco as mj
import numpy as np
import mujoco.viewer as mjviewer
import logging


# Configure logging
logging.basicConfig(
handlers=[logging.FileHandler("logs/simulation.log"), logging.StreamHandler()],
level=logging.INFO,
format="%(asctime)s: %(levelname)s: %(name)s: %(message)s"
)
logger = logging.getLogger(__name__)

logger.info("Start Mujoco Simulation")

model = mj.MjModel.from_xml_path('./simulator/scene.xml')
data = mj.MjData(model)
cam = mj.MjvCamera()
opt = mj.MjvOption()

with mjviewer.launch_passive(model, data, show_left_ui=False, show_right_ui=True) as viewer:

    # Set the camera view
    viewer.cam.distance = 5.0
    viewer.cam.azimuth = 90
    viewer.cam.elevation = -20

    # Simulation Loop
    while viewer.is_running():
        # Step the simulation
        mj.mj_step(model, data)

        # Sync the viewer with the simulation state
        viewer.sync()

