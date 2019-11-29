﻿using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK;
using TMPro;

public class CubeInstanciater : Singleton<CubeInstanciater> {

    #region fields
    public Transform _zone;

    public GameObject _detectedObject;

    public int _totalCube;

     public testSelection _testSelection; 

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

    [SerializeField] TextMeshProUGUI _redText;
    [SerializeField] TextMeshProUGUI _blueText;
    [SerializeField] TextMeshProUGUI _greenText;
    [SerializeField] TextMeshProUGUI _whiteText;


    VRTK_ControllerEvents _controller;

    GameObject _selectedCube;

    Transform _nearCube;

    float _placementTimer;

    [SerializeField] int[] _colorCount = new int[6];
    
    int _selectedColor;

    int _layerMask = 1 << 8;


    public bool _canBuild = true;
    #endregion fields

    void Start()
    {
        _canBuild = true;
      //  ChangeSelectedCube("Green");
        _selectedColor = 0;

        _testSelection.GetComponent<testSelection>();
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
                //_colorSelectObject.GetComponent<VRTK_TransformFollow>().gameObjectToFollow = _controller.gameObject;
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

        _greenText.text = _colorCount[0].ToString();
        _redText.text = _colorCount[1].ToString();
        _blueText.text = _colorCount[3].ToString();
        _whiteText.text = _colorCount[5].ToString();

        if(_testSelection.index != 0)

        {
            if (_testSelection.index == 1)
        {
            _selectedCube = _blueCubePrefab;
            _selectedColor = 3;
        }

        if (_testSelection.index == 2)
        {
            _selectedCube = _redCubePrefab;
            _selectedColor = 1;
        }

        if (_testSelection.index == 3)
        {
            _selectedCube = _greenCubePrefab;
            _selectedColor = 0;
        }

        if (_testSelection.index == 4)
        {
            _selectedCube = _whiteCubePrefab;
            _selectedColor = 5;

        }

       /* if (_testSelection.index == 5)
        {
            _selectedCube = _yellowCubePrefab;
            _selectedColor = 2;
        }*/


        }
    }

    private void LaserPointer(VRTK_ControllerEvents vRTK_CE)
    {
        ChangeActive(true);

        RaycastHit hit;

        if(Physics.Raycast(vRTK_CE.transform.position, vRTK_CE.transform.forward, out hit, Mathf.Infinity, _layerMask))
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
            Debug.Log(hit.collider.name);
            _nearCube = hit.collider.GetComponentInParent<AssignFaceColorByTag>().transform;
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
                if(_totalCube > 0)
                {
                    GameObject go = Instantiate(_selectedCube, _previewCube.transform.position, _previewCube.transform.rotation, _zone);
                    go.transform.localScale = new Vector3(1, 1, 1);
                    _placementTimer = 0;
                    _colorCount[_selectedColor]--;
                    _totalCube--;
                }
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

  /*  public void ChangeSelectedCube(string color)
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

        _totalCube++;
    }
}
