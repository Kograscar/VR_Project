using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK;

public class PlaceCube : MonoBehaviour {

    public bool _canBuild;

    VRTK_ControllerEvents _rightCE;
    VRTK_ControllerEvents _leftCE;

    LineRenderer _leftLR;
    LineRenderer _rightLR;

    Grid _grid;

    private void OnEnable()
    {
        StartCoroutine(GetActualController());

        FindObjectOfType<Grid>();
    }

    private void Update()
    {
        if (_canBuild)
        {
            if (_leftCE.gripClicked)
            {
                LaserPointer(_leftCE);
            }
            else
                _leftLR.enabled = false;

            if (_rightCE.gripClicked)
            {
                LaserPointer(_rightCE);
            }
            else
                _rightLR.enabled = false;
        }
    }

    private void LaserPointer(VRTK_ControllerEvents vRTK_CE)
    {
        RaycastHit hit;

        if(Physics.Raycast(vRTK_CE.transform.position, vRTK_CE.transform.forward, out hit, Mathf.Infinity))
        {
            if(vRTK_CE == _leftCE)
            {
                _leftLR.enabled = true;
                _leftLR.SetPosition(0, vRTK_CE.transform.position);
                _leftLR.SetPosition(1, hit.point);
            }
            else
            {
                _rightLR.enabled = true;
                _rightLR.SetPosition(0, vRTK_CE.transform.position);
                _rightLR.SetPosition(1, hit.point);
            }
        }

        FindObjectOfType<Grid>().GetNearestPointOnGrid(hit.point);
    }

    IEnumerator GetActualController() {
        yield return new WaitForEndOfFrame();

        _rightCE = VRTK_DeviceFinder.DeviceTransform(VRTK_DeviceFinder.Devices.RightController).GetComponent<VRTK_ControllerEvents>();
        _leftCE = VRTK_DeviceFinder.DeviceTransform(VRTK_DeviceFinder.Devices.LeftController).GetComponent<VRTK_ControllerEvents>();
    }
}
