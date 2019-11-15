using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK;

public class PlaceCube : MonoBehaviour {

    public bool _canBuild = true;

    VRTK_ControllerEvents _rightCE;
    //VRTK_ControllerEvents _leftCE;

    //[SerializeField] LineRenderer _leftLR;
    [SerializeField] LineRenderer _rightLR;

    [SerializeField] GameObject _previewCube;

    Grid _grid;
    private object sender;

    int _redCube;
    int _greenCube;
    int _blueCube;

    private void OnEnable()
    {
        _canBuild = true;
        StartCoroutine(GetActualController());
    }

    private void Update()
    {
        if (/*_leftCE == null ||*/ _rightCE == null)
        {
            StartCoroutine(GetActualController());
        }

        if (_canBuild)
        {
            /*if (_leftCE.gripPressed)
            {
                LaserPointer(_leftCE);
            }
            else
            {
                _leftLR.enabled = false;
            }*/

            if (_rightCE.gripPressed)
            {
                LaserPointer(_rightCE);
            }
            else
            {
                ChangeActive(false);
            }
        }
        else
        {
            ChangeActive(false);
        }
    }

    private void LaserPointer(VRTK_ControllerEvents vRTK_CE)
    {
        ChangeActive(true);

        RaycastHit hit;

        if(Physics.Raycast(vRTK_CE.transform.position, vRTK_CE.transform.forward, out hit, Mathf.Infinity))
        {
            /*if (vRTK_CE == _leftCE)
            {
                _leftLR.enabled = true;
                _leftLR.SetPosition(0, vRTK_CE.transform.position);
                _leftLR.SetPosition(1, hit.point);
            }
            else
            {*/
                _rightLR.enabled = true;
                _rightLR.SetPosition(1, hit.point);
            //}
            
            if (_grid == null)
            {
                _grid = FindObjectOfType<Grid>();
            }

            Vector3 nearPoint = _grid.GetNearestPointOnGrid(hit.point);
            _previewCube.transform.position = nearPoint;
        }
        else
        {
            _previewCube.SetActive(false);
            _rightLR.SetPosition(1, vRTK_CE.transform.position + vRTK_CE.transform.forward * 1000);
        }

        _rightLR.SetPosition(0, _rightCE.transform.position);

    }

    public void LoadCube(int red, int green, int blue)
    {
        _redCube = red;
        _greenCube = green;
        _blueCube = blue;
    }

    void ChangeActive(bool state)
    {
        //_leftLR.enabled = state;
        _rightLR.enabled = state;
        _previewCube.SetActive(state);
    }

    IEnumerator GetActualController() {
        yield return new WaitForEndOfFrame();

        _rightCE = VRTK_DeviceFinder.DeviceTransform(VRTK_DeviceFinder.Devices.RightController).GetComponent<VRTK_ControllerEvents>();
        //_leftCE = VRTK_DeviceFinder.DeviceTransform(VRTK_DeviceFinder.Devices.LeftController).GetComponent<VRTK_ControllerEvents>();

        /*if(_rightCE != null && _leftCE != null)
        {
            _rightCE.GripClicked += (object sender, ControllerInteractionEventArgs e) =>
            {
                LaserPointer(_rightCE);
            };
        }*/

        /*if(_rightCE != null)
        {
            Debug.Log("Right : " + _rightCE.gameObject.name);
        }
        else
        {
            Debug.Log("Right : null");
        }

        if (_leftCE != null)
        {
            Debug.Log("Left : " + _leftCE.gameObject.name);
        }
        else
        {
            Debug.Log("Left : null");
        }*/
    }
}
