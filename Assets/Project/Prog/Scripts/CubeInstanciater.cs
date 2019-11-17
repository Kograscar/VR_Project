using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK;

public class CubeInstanciater : MonoBehaviour {

    VRTK_ControllerEvents _rightCE;

    [SerializeField] LineRenderer _rightLR;

    [SerializeField] GameObject _previewCube;
    [SerializeField] GameObject _redCubePrefab;
    [SerializeField] GameObject _greenCubePrefab;
    [SerializeField] GameObject _blueCubePrefab;

    [SerializeField] int _redCubeCount;
    [SerializeField] int _greenCubeCount;
    [SerializeField] int _blueCubeCount;

    [SerializeField] float _placementDelay;


    Grid _grid;

    float _placementTimer;


    public int _selectedColor;

    public bool _canBuild = true;
    

    private void OnEnable()
    {
        _canBuild = true;
        StartCoroutine(GetActualController());
    }

    private void Update()
    {
        _placementTimer += Time.deltaTime;

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

        if (_previewCube.activeInHierarchy)
        {
            if (_rightCE.triggerPressed)
            {
                if(_placementTimer >= _placementDelay)
                {
                    PlaceCube();
                }
            }
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

            if(nearPoint.y == 0)
            {
                _previewCube.transform.position = nearPoint
                    /*+ new Vector3(0, _previewCube.transform.lossyScale.y / 2, 0)*/;
            }
            else
            {
                _previewCube.transform.position = _grid.GetNearestPointOnGrid(hit.point + hit.collider.transform.up * (_grid.size / 2) - new Vector3(0, _previewCube.transform.lossyScale.y / 2, 0))
                    /*hit.collider.transform.position - hit.collider.transform.forward / (1 / _grid.size)*/;
            }
        }
        else
        {
            _previewCube.SetActive(false);
            _rightLR.SetPosition(1, vRTK_CE.transform.position + vRTK_CE.transform.forward * 1000);
        }

        _rightLR.SetPosition(0, _rightCE.transform.position);

    }
    
    void PlaceCube()
    {

        GameObject newCube = _redCubePrefab;

        switch (_selectedColor)
        {
            case 1:

                if(_greenCubeCount > 0)
                {
                    newCube = _greenCubePrefab;
                }

                break;
        
            case 2:

                if (_redCubeCount > 0)
                {
                    newCube = _redCubePrefab;
                }

                break;
        
            case 4:



                break;
        
            case 6:

                if (_blueCubeCount > 0)
                {
                    newCube = _blueCubePrefab;
                }

                break;
        
            case 8:



                break;
        
            case 9:



                break;
        }
        
        Instantiate(newCube, _previewCube.transform.position, _previewCube.transform.rotation);
        _placementTimer = 0;
    }

    public void LoadCube(int red, int green, int blue)
    {
        _redCubeCount = red;
        _greenCubeCount = green;
        _blueCubeCount = blue;
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
