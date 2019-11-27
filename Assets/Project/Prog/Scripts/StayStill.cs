using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK;

public class StayStill : MonoBehaviour
{
    VRTK_ControllerEvents _controllerR;
    VRTK_ControllerEvents _controllerL;

    private void Update()
    {
        if (_controllerR == null)
        {
            _controllerR = VRTK_DeviceFinder.DeviceTransform(VRTK_DeviceFinder.Devices.RightController).GetComponent<VRTK_ControllerEvents>();
        }
        else
        {
            _controllerR.transform.rotation = new Quaternion();
        }

        if(_controllerL == null)
        {
            _controllerL = VRTK_DeviceFinder.DeviceTransform(VRTK_DeviceFinder.Devices.RightController).GetComponent<VRTK_ControllerEvents>();
        }
        else
        {
            _controllerL.transform.rotation = new Quaternion();
        }
    }
}
