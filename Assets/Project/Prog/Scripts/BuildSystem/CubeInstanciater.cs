using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK;

public class CubeInstanciater : Singleton<CubeInstanciater> {

    #region fields
    [HideInInspector] public GameObject _detectedObject;


    [SerializeField] LineRenderer _lineRenderer;

    [SerializeField] GameObject _colorSelectObject;
    [SerializeField] GameObject _previewCube;
    [SerializeField] GameObject _redCubePrefab;
    [SerializeField] GameObject _greenCubePrefab;
    [SerializeField] GameObject _blueCubePrefab;
    [SerializeField] GameObject _yellowCubePrefab;
    [SerializeField] GameObject _purpleCubePrefab;
    [SerializeField] GameObject _whiteCubePrefab;

    [SerializeField] Material _previewMaterial;

    [SerializeField] float _placementDelay;


    VRTK_ControllerEvents _controller;

    GameObject _selectedCube;

    float _placementTimer;

    int[] _colorCount = new int[6];
    
    int _selectedColor;


    public bool _canBuild = true;
    #endregion fields

    void Start()
    {
        _canBuild = true;
        ChangeSelectedCube("Green");
        _selectedColor = 0;
    }

    private void OnEnable()
    {
        _previewCube.GetComponent<MeshRenderer>().material = _previewMaterial;
    }

    private void Update()
    {
        _placementTimer += Time.deltaTime;

        if (_controller == null)
        {
            _controller = VRTK_DeviceFinder.DeviceTransform(VRTK_DeviceFinder.Devices.RightController).GetComponent<VRTK_ControllerEvents>();
            if(_controller != null)
            {
                _colorSelectObject.GetComponent<VRTK_TransformFollow>().gameObjectToFollow = _controller.gameObject;
            }
        }
        else
        {
            if (_canBuild)
            {

                if (_controller.gripPressed)
                {
                    LaserPointer(_controller);
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

        if (_previewCube.activeInHierarchy)
        {
            if (_controller.triggerPressed)
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
            _lineRenderer.enabled = true;
            _lineRenderer.enabled = true;
            _lineRenderer.SetPosition(1, hit.point);

            Vector3 nearPoint = VirtualGrid.Instance.GetNearestPointOnGrid(hit.point);

            if(nearPoint.y == 0)
            {
                _previewCube.transform.position = nearPoint;
            }
            else
            {
                _previewCube.transform.position = VirtualGrid.Instance.GetNearestPointOnGrid(hit.point + hit.collider.transform.up * (_previewCube.transform.lossyScale.x / 2) - new Vector3(0, _previewCube.transform.lossyScale.y / 2, 0));
            }
        }
        else
        {
            _previewCube.SetActive(false);
            _lineRenderer.SetPosition(1, vRTK_CE.transform.position + vRTK_CE.transform.forward * 1000);
        }

        _lineRenderer.SetPosition(0, _controller.transform.position);

    }
    
    void PlaceCube()
    {
        if (_detectedObject == null)
        {
            if (_colorCount[_selectedColor] > 0)
            {
                Instantiate(_selectedCube, _previewCube.transform.position, _previewCube.transform.rotation);
                _placementTimer = 0;
                _colorCount[_selectedColor]--;
            }
        }
    }

    void ChangeActive(bool state)
    {
        _lineRenderer.enabled = state;
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

    /*public enum Colore
    {
        Green,
        Blue
    }*/

    public void ReceiveCube(string tag)
    {
        /*Colore colore = (Colore)Enum.Parse(typeof(Colore), tag); // string to enum 'Colore'

        int index = (int)colore; // enum 'Colore' to int index

        _colorCount[index]++;*/

        switch (tag)
        {

            case "Green":
                _colorCount[0]++;

                break;

            case "Red":
                _colorCount[1]++;

                break;

            case "Yellow":
                _colorCount[2]++;

                break;

            case "Blue":
                _colorCount[3]++;

                break;

            case "Purple":
                _colorCount[4]++;

                break;

            case "White":
                _colorCount[5]++;

                break;
        }
    }
}
