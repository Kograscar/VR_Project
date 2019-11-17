using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK;

public class CubeInstanciater : Singleton<CubeInstanciater> {

    #region fields
    [SerializeField] LineRenderer _rightLR;

    [SerializeField] GameObject _previewCube;
    [SerializeField] GameObject _redCubePrefab;
    [SerializeField] GameObject _greenCubePrefab;
    [SerializeField] GameObject _blueCubePrefab;
    [SerializeField] GameObject _yellowCubePrefab;
    [SerializeField] GameObject _purpleCubePrefab;
    [SerializeField] GameObject _whiteCubePrefab;

    [SerializeField] float _placementDelay;


    VRTK_ControllerEvents _rightCE;

    GameObject _selectedCube;

    Grid _grid;

    float _placementTimer;

    int[] _colorCount = new int[6];
    
    int _selectedColor;


    public bool _canBuild = true;
    #endregion fields

    private void OnEnable()
    {
        _canBuild = true;
        StartCoroutine(GetActualController());
        ChangeSelectedCube("Green");
        _selectedColor = 0;
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
                _previewCube.transform.position = nearPoint;
            }
            else
            {
                _previewCube.transform.position = _grid.GetNearestPointOnGrid(hit.point + hit.collider.transform.up * (_grid.size / 2) - new Vector3(0, _previewCube.transform.lossyScale.y / 2, 0));
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
        if(_colorCount[_selectedColor] > 0)
        {
            Instantiate(_selectedCube, _previewCube.transform.position, _previewCube.transform.rotation);
            _placementTimer = 0;
            _colorCount[_selectedColor]--;
        }
    }

    void ChangeActive(bool state)
    {
        //_leftLR.enabled = state;
        _rightLR.enabled = state;
        _previewCube.SetActive(state);
    }

    public void LoadCube(int green, int red, int yellow, int blue, int purple, int white)
    {
        _colorCount[0] = green;
        _colorCount[1] = red;
        _colorCount[2] = yellow;
        _colorCount[3] = blue;
        _colorCount[4] = purple;
        _colorCount[5] = white;
    }

    public void ChangeSelectedCube(string color)
    {
        switch (color)
        {
            case "Green":
                _selectedCube = _greenCubePrefab;
                _selectedColor = 0;

                break;

            case "Red":
                _selectedCube = _redCubePrefab;
                _selectedColor = 1;

                break;

            case "Yellow":
                _selectedCube = _yellowCubePrefab;
                _selectedColor = 2;

                break;

            case "Blue":
                _selectedCube = _blueCubePrefab;
                _selectedColor = 3;
                break;

            case "Purple":
                _selectedCube = _purpleCubePrefab;
                _selectedColor = 4;

                break;

            case "White":
                _selectedCube = _whiteCubePrefab;
                _selectedColor = 5;

                break;
        }
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
