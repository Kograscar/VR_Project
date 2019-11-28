using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK;

public class CubeRemover : Singleton<CubeRemover> {

    [HideInInspector] public GameObject _detectedObject;


    [SerializeField] float _destructionDelay;

    [SerializeField] LineRenderer lineRenderer;

    [SerializeField] GameObject _previewCube;
    [SerializeField] GameObject _deleteFX;

    [SerializeField] Material _previewMaterial;


    VRTK_ControllerEvents _controller;


    bool _canBuild;

    float _destructionTimer;

    int _layerMask = 1 << 8;

    private void Start()
    {
        _canBuild = true;
    }

    private void OnEnable()
    {
        _previewCube.GetComponent<MeshRenderer>().material = _previewMaterial;
    }

    private void Update()
    {
        if (_controller == null)
        {
            _controller = VRTK_DeviceFinder.DeviceTransform(VRTK_DeviceFinder.Devices.RightController).GetComponent<VRTK_ControllerEvents>();
        }
        else
        {
            if (_canBuild)
            {

                if (_controller.gripPressed)
                {
                    LaserPointer();
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
                if (_destructionTimer >= _destructionDelay)
                {
                    RemoveCube();
                }
            }
        }

        _destructionTimer += Time.deltaTime;
    }

    void LaserPointer()
    {
        ChangeActive(true);

        RaycastHit hit;

        if (Physics.Raycast(_controller.transform.position, _controller.transform.forward, out hit, Mathf.Infinity, _layerMask))
        {
            lineRenderer.enabled = true;
            lineRenderer.enabled = true;
            lineRenderer.SetPosition(1, hit.point);

            Vector3 nearPoint = VirtualGrid.Instance.GetNearestPointOnGrid(hit.point);

            if (nearPoint.y == 0)
            {
                _previewCube.transform.position = nearPoint;
            }
            else
            {
                _previewCube.transform.position = VirtualGrid.Instance.GetNearestPointOnGrid(hit.point - hit.collider.transform.up * (_previewCube.transform.lossyScale.x / 2) - new Vector3(0, _previewCube.transform.lossyScale.x / 2, 0));
            }
        }
        else
        {
            _previewCube.SetActive(false);
            lineRenderer.SetPosition(1, _controller.transform.position + _controller.transform.forward * 1000);
        }

        lineRenderer.SetPosition(0, _controller.transform.position);
    }

    void RemoveCube()
    {
        if(_detectedObject != null)
        {
            Destroy(Instantiate(_deleteFX, _detectedObject.transform.position, _detectedObject.transform.rotation), 3f);
            CubeInstanciater.Instance.ReceiveCube(_detectedObject.tag);
            Destroy(_detectedObject);
            _destructionTimer = 0;
        }
    }

    void ChangeActive(bool state)
    {
        lineRenderer.enabled = state;
        _previewCube.SetActive(state);
    }
}
