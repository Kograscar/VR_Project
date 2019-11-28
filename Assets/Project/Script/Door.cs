using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK.Controllables;
using VRTK.Controllables.ArtificialBased;

public class Door : MonoBehaviour
{

    VRTK_ArtificialPusher _pusher;
    [SerializeField] private GameObject _Door = null;
    
    [SerializeField] private float _DelayForMoveDoor = 0.1f;
    [SerializeField] private float _DelayForWaitToCloseDoor = 10f;
    [SerializeField] private float _Vitesse = 0.1f;
    [SerializeField] private Transform _OffsetForOpen = null;
    [SerializeField] private Transform _OffsetForClose = null;
    [SerializeField] private bool _CanOpen = false;
    [SerializeField] private bool _IsOpen = false;
    [SerializeField] private GameObject _Lock = null;

    [SerializeField] private Material _CanBeOpen;
    [SerializeField] private Material _CantBeOpen;
    [SerializeField] private Material _IsInteract;
    [SerializeField] private MeshRenderer _PusherMeshRenderer;
    [SerializeField] private Collider _Levier;
    [SerializeField] private bool _CanchangeMaterial = true;

    void Start()
    {
        _PusherMeshRenderer = GetComponent<MeshRenderer>();
        _pusher = GetComponent<VRTK_ArtificialPusher>();
        _pusher.MinLimitExited += (object sender, ControllableEventArgs e) =>
        {
            if(_CanOpen == true && _IsOpen == false)
            {
                StopCoroutine(MoveDoorForClose());
                Debug.Log("Open");
                StartCoroutine(MoveDoorForOpen());
            }else
            {
                Debug.Log("Lock");
            }
        };
    }
    private void Update()
    {
        if(_IsOpen == true)
        {
            StopCoroutine(MoveDoorForOpen());
        }

        if (_Lock == null && _Levier.enabled == true)
        {
            _CanOpen = true;

            if(_CanchangeMaterial == true)
            {
                _PusherMeshRenderer.material = _CanBeOpen;

            }
        }

        if (_Lock != null || _Levier.enabled == false)
        {
            _CanOpen = false;
            if (_CanchangeMaterial == true)
            {
                _PusherMeshRenderer.material = _CantBeOpen;
            }
        }
    }
    private IEnumerator MoveDoorForOpen()
    {
        Debug.Log("toopenone");
        if(_Door.transform.position.y < _OffsetForOpen.transform.position.y)
        {
            _PusherMeshRenderer.material = _IsInteract;
            _CanchangeMaterial = false;
            _Door.transform.Translate(0, _Vitesse, 0);
        }
        else
        {
            _IsOpen = true;
            StartCoroutine(WaitForClose());
            _CanchangeMaterial = true;
        }
        yield return new WaitForSeconds(_DelayForMoveDoor);
        if(_IsOpen != true)
        {
        StartCoroutine(MoveDoorForOpen());
        }
        else
        {
            yield return null;
        }
    }

    private IEnumerator WaitForClose()
    {
        yield return new WaitForSeconds(_DelayForWaitToCloseDoor);
        StartCoroutine(MoveDoorForClose());
    }

    private IEnumerator MoveDoorForClose()
    {
        Debug.Log("tocloseone");
        if (_Door.transform.position.y > _OffsetForClose.transform.position.y)
        {
            _PusherMeshRenderer.material = _IsInteract;
            _CanchangeMaterial = false;
            _Door.transform.Translate(0, -_Vitesse, 0);
          
        }
        else
        {
            _IsOpen = false;
            StopCoroutine(WaitForClose());
            _CanchangeMaterial = true;
        }

        yield return new WaitForSeconds(_DelayForMoveDoor);
        if(_IsOpen != false)
        {
        StartCoroutine(MoveDoorForClose());
        }
        else
        {
            yield return null;
        }
    }

}
