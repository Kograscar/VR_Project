using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK.Controllables;
using VRTK.Controllables.ArtificialBased;

public class Door : MonoBehaviour
{

    VRTK_ArtificialPusher _pusher;
    [SerializeField] private GameObject _DoorRightToMove = null;
    [SerializeField] private GameObject _DoorLeftToMove = null;
    [SerializeField] private float _DelayForMoveDoor = 0.1f;
    [SerializeField] private float _DelayForWaitToCloseDoor = 10f;
    [SerializeField] private float _Vitesse = 0.1f;
    [SerializeField] private Transform _OffsetForOpen = null;
    [SerializeField] private Transform _OffsetForClose = null;
    [SerializeField] private bool _CanOpen = false;
    [SerializeField] private bool _IsOpen = false;

    [SerializeField] private GameObject _Lock = null;

    void Start()
    {
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

        if (_Lock == null)
        {
            _CanOpen = true;
        }
    }
    private IEnumerator MoveDoorForOpen()
    {
        Debug.Log("toopenone");
        if(_DoorRightToMove.transform.position != _OffsetForOpen.transform.position)
        {
        _DoorRightToMove.transform.Translate(-_Vitesse, 0, 0);
        _DoorLeftToMove.transform.Translate(-_Vitesse, 0, 0);
        }
        else
        {
            _IsOpen = true;
            StartCoroutine(WaitForClose());
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
        if (_DoorRightToMove.transform.position != _OffsetForClose.transform.position)
        {
            _DoorRightToMove.transform.Translate(_Vitesse, 0, 0);
            _DoorLeftToMove.transform.Translate(_Vitesse, 0, 0);
        }
        else
        {
            _IsOpen = false;
            StopCoroutine(WaitForClose());
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
