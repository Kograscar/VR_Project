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
    [SerializeField] private float _Delay = 0.1f;
    [SerializeField] private float _Vitesse = 0.1f;
    [SerializeField] private Transform _Offset = null;
    [SerializeField] private bool _CanOpen = false;
    [SerializeField] private bool _IsOpen = false;

    void Start()
    {
        _pusher = GetComponent<VRTK_ArtificialPusher>();
        _pusher.MinLimitExited += (object sender, ControllableEventArgs e) =>
        {
            if(_CanOpen == true && _IsOpen == false)
            {
                Debug.Log("Open");
                StartCoroutine(MoveDoor());
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
            StopAllCoroutines();
        }
    }
    private IEnumerator MoveDoor()
    {
        if(_DoorRightToMove.transform.position != _Offset.transform.position)
        {
        _DoorRightToMove.transform.Translate(-_Vitesse, 0, 0);
        _DoorLeftToMove.transform.Translate(-_Vitesse, 0, 0);
        }
        else
        {
            _IsOpen = true;
            yield return null;
        }
        yield return new WaitForSeconds(_Delay);
        StartCoroutine(MoveDoor());
    }

}
