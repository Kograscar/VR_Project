using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK;

public class AssignController : MonoBehaviour {
    
    VRTK_ControllerEvents _controller;

    void Update () {

        if (_controller == null)
        {
            _controller = VRTK_DeviceFinder.DeviceTransform(VRTK_DeviceFinder.Devices.RightController).GetComponent<VRTK_ControllerEvents>();
            if (_controller != null)
            {
                GetComponent<VRTK_TransformFollow>().gameObjectToFollow = _controller.gameObject;
            }
        }
    }
}